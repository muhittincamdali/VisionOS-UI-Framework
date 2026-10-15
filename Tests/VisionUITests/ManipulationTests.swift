import simd
import Testing
@testable import VisionUI

@Suite("Spatial bounds")
struct SpatialBoundsTests {
    @Test("corners in any order make the same box")
    func sortedCorners() {
        let box = SpatialBounds(min: [1, -2, 3], max: [-1, 2, -3])
        #expect(box.min == [-1, -2, -3])
        #expect(box.max == [1, 2, 3])
        #expect(box.center == .zero)
        #expect(box.size == [2, 4, 6])
        #expect(SpatialBounds(center: [1, 1, 1], size: [-2, 2, 2]) == SpatialBounds(min: [0, 0, 0], max: [2, 2, 2]))
    }

    @Test("clamp keeps points inside and replaces NaN with the center")
    func clamping() {
        let box = SpatialBounds(center: .zero, size: [1, 1, 1])
        #expect(box.clamp([2, -2, 0.25]) == [0.5, -0.5, 0.25])
        #expect(box.clamp([.nan, 0.1, .nan]) == [0, 0.1, 0])
        #expect(box.contains([0.5, 0.5, 0.5]))
        #expect(!box.contains([0.5, 0.51, 0]))
    }

    @Test("infinite and NaN corners become a finite box")
    func hostileCorners() {
        let box = SpatialBounds(min: [-.infinity, .nan, 0], max: [.infinity, 1, .infinity])
        let limit = SpatialLayoutLimits.maximumLength
        #expect(box.min == [-limit, 0, 0])
        #expect(box.max == [limit, 1, limit])
        #expect(box.center.x.isFinite && box.center.z.isFinite)
        #expect(box.clamp([.infinity, .nan, -.infinity]) == [limit, 0.5, 0])
    }
}

@Suite("Manipulation state")
struct ManipulationStateTests {
    @Test("a drag moves from where the drag began, inside the bounds")
    func dragging() {
        var state = ManipulationState(constraints: .init(bounds: SpatialBounds(center: .zero, size: [1, 1, 1])))
        state.drag(translation: [0.1, 0, 0])
        state.drag(translation: [0.2, 0.1, 0])   // the total since the start, not a step
        #expect(isClose(state.position, [0.2, 0.1, 0]))
        state.drag(translation: [3, 0, -3])
        #expect(state.position == [0.5, 0, -0.5])
        #expect(state.isInteracting)
        state.endDrag()
        #expect(!state.isInteracting)
        state.drag(translation: [-0.1, 0, 0])
        #expect(isClose(state.position, [0.4, 0, -0.5]))
    }

    @Test("a pinch scales from the scale it began with, inside the range")
    func magnifying() {
        var state = ManipulationState(scale: 1, constraints: .init(scaleRange: 0.5...2))
        state.magnify(by: 1.5)
        state.magnify(by: 1.8)
        #expect(isClose(state.scale, 1.8))
        state.magnify(by: 10)
        #expect(state.scale == 2)
        state.endMagnify()
        state.magnify(by: 0.1)
        #expect(state.scale == 0.5)
    }

    @Test("simultaneous gestures each keep their own starting point")
    func simultaneous() {
        var state = ManipulationState()
        state.drag(translation: [0.2, 0, 0])
        state.magnify(by: 2)
        state.endMagnify()                       // the pinch ends first
        state.drag(translation: [0.3, 0, 0])     // the drag goes on from its own start
        #expect(isClose(state.position, [0.3, 0, 0]))
        #expect(state.scale == 2)
    }

    @Test("glitched gesture values are ignored")
    func hostileValues() {
        var state = ManipulationState(position: [0.1, 0.2, 0.3], scale: 1.5)
        let before = state
        for value in [Float.nan, .infinity, -.infinity] {
            state.drag(translation: [value, 0, 0])
            state.magnify(by: value)
            state.rotate(by: simd_quatf(vector: [value, 0, 0, 1]))
            state.move(to: [0, value, 0])
        }
        state.magnify(by: 0)
        state.magnify(by: -2)
        state.rotate(by: simd_quatf(vector: .zero))
        #expect(state == before)
        // A huge factor would overflow the scale; it is clamped instead.
        var unbounded = ManipulationState(scale: 100, constraints: .init(scaleRange: 1...Float.greatestFiniteMagnitude))
        unbounded.magnify(by: .greatestFiniteMagnitude)
        #expect(unbounded.scale == 100)
    }

    @Test("without bounds the position stays within the length limit")
    func unboundedPosition() {
        let limit = SpatialLayoutLimits.maximumLength
        // Without the limit, moving to 3e38 and then dragging by 3e38 added up to infinity.
        var state = ManipulationState()
        state.move(to: [3e38, 0, 0])
        #expect(state.position == [limit, 0, 0])
        state.drag(translation: [3e38, -3e38, 0])
        #expect(state.position == [limit, -limit, 0])
        state.endDrag()
        state.drag(translation: [-3e38, 0, 0])
        #expect(state.position == [-limit, -limit, 0])
        #expect(ManipulationState(position: [1e30, -1e30, 5]).position == [limit, -limit, 5])
    }

    @Test("huge but finite quaternions keep their rotation")
    func hugeQuaternions() {
        // The length of these overflows to infinity; normalizing by it gave a zero quaternion and
        // a matrix that collapsed the object to a point.
        let huge = simd_quatf(vector: [3e38, 3e38, 0, 0])
        let halfTurn = simd_quatf(angle: .pi, axis: simd_normalize(SIMD3<Float>(1, 1, 0)))
        let state = ManipulationState(orientation: huge)
        #expect(isSameRotation(state.orientation, halfTurn))
        #expect(isClose(simd_length(state.matrix.columns.0), 1))

        var turning = ManipulationState()
        turning.rotate(by: simd_quatf(vector: [0, 3e38, 0, 3e38]))
        #expect(isSameRotation(turning.orientation, SpatialMath.yawRotation(.pi / 2)))

        var yawOnly = ManipulationState(constraints: .init(rotation: .yaw))
        yawOnly.rotate(by: simd_quatf(vector: [0, 3e38, 0, 3e38]))
        #expect(isSameRotation(yawOnly.orientation, SpatialMath.yawRotation(.pi / 2)))
        // Tiny quaternions still count as zero.
        #expect(ManipulationState(orientation: simd_quatf(vector: [1e-30, 0, 0, 0])).orientation == SpatialMath.identity)
    }

    @Test("yaw-only rotation drops tilt and snaps when it ends")
    func yawOnly() {
        var state = ManipulationState(constraints: .init(rotation: .yaw, yawSnapAngle: .pi / 4))
        let tiltedTurn = simd_quatf(angle: 0.3, axis: [1, 0, 0]) * simd_quatf(angle: 0.7, axis: [0, 1, 0])
        state.rotate(by: tiltedTurn)
        // Only the turn around +y is kept, so +y still points up.
        #expect(isClose(state.orientation.act([0, 1, 0]), [0, 1, 0]))
        #expect(isClose(ManipulationState.yawAngle(of: state.orientation), 0.7, within: 0.05))
        state.endRotation()
        #expect(isClose(ManipulationState.yawAngle(of: state.orientation), .pi / 4))
    }

    @Test("free rotation composes with the starting orientation; locked rotation does nothing")
    func freeAndLocked() {
        var free = ManipulationState(orientation: SpatialMath.yawRotation(0.5))
        free.rotate(by: simd_quatf(angle: 0.25, axis: [0, 1, 0]))
        free.rotate(by: simd_quatf(angle: 0.5, axis: [0, 1, 0]))
        #expect(isSameRotation(free.orientation, SpatialMath.yawRotation(1)))

        var locked = ManipulationState(orientation: SpatialMath.yawRotation(0.5), constraints: .init(rotation: .locked))
        #expect(locked.orientation == SpatialMath.identity)
        locked.rotate(by: simd_quatf(angle: 1, axis: [0, 1, 0]))
        #expect(locked.orientation == SpatialMath.identity)
    }

    @Test("new constraints move the object inside them")
    func changingConstraints() {
        var state = ManipulationState(position: [2, 0, 0], scale: 3)
        state.constraints = .init(bounds: SpatialBounds(center: .zero, size: [1, 1, 1]), scaleRange: 0.5...1)
        #expect(state.position == [0.5, 0, 0])
        #expect(state.scale == 1)
    }

    @Test("invalid scale ranges are replaced with positive finite ones")
    func scaleRanges() {
        #expect(ManipulationConstraints(scaleRange: 0...Float.infinity).scaleRange == 0.01...100)
        #expect(ManipulationConstraints(scaleRange: -5 ... -1).scaleRange == 0.01...100)
        #expect(ManipulationConstraints(scaleRange: 2...200).scaleRange == 2...200)
        var constraints = ManipulationConstraints()
        constraints.setScaleRange(-Float.infinity...Float.infinity)
        #expect(constraints.scaleRange == 0.01...100)
        constraints.setScaleRange(5...5)
        #expect(constraints.scaleRange == 5...5)
        #expect(ManipulationState(scale: .nan).scale == 1)
    }

    @Test("the matrix scales, then rotates, then moves")
    func matrix() {
        let state = ManipulationState(position: [1, 2, 3], scale: 2, orientation: SpatialMath.yawRotation(.pi / 2))
        let point = state.matrix * SIMD4<Float>(0, 0, 1, 1)
        // (0, 0, 1) scaled to (0, 0, 2), turned to (2, 0, 0), moved to (3, 2, 3).
        #expect(isClose(SIMD3<Float>(point.x, point.y, point.z), [3, 2, 3]))
    }
}
