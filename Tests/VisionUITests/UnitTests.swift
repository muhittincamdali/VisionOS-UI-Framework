import CoreGraphics
import simd
import Testing
@testable import VisionUI

@Suite("Units")
struct UnitTests {
    @Test("points with y down become meters with y up")
    func meters() {
        #expect(SpatialUnits.meters(fromPoints: 100, 50, -20, pointsPerMeter: 100) == [1, -0.5, -0.2])
    }

    @Test("flipping y twice gives the original rotation")
    func flippingY() {
        let rotation = simd_quatf(angle: 0.8, axis: simd_normalize([1, 2, 3]))
        #expect(SpatialUnits.flippingY(SpatialUnits.flippingY(rotation)) == rotation)
        // A turn around y stays the same turn; a turn around x reverses.
        let yaw = SpatialMath.yawRotation(0.4)
        #expect(SpatialUnits.flippingY(yaw) == yaw)
        let pitch = simd_quatf(angle: 0.4, axis: [1, 0, 0])
        #expect(isSameRotation(SpatialUnits.flippingY(pitch), simd_quatf(angle: -0.4, axis: [1, 0, 0])))
    }

    @Test("a flipped rotation moves flipped points the same way")
    func flipConsistency() {
        let rotation = simd_quatf(angle: 1.1, axis: simd_normalize([0.3, -1, 0.6]))
        let point = SIMD3<Float>(0.2, 0.7, -0.4)
        let flip = SIMD3<Float>(1, -1, 1)
        // Rotating in y-up space and flipping equals flipping and rotating in y-down space.
        #expect(isClose(rotation.act(point) * flip, SpatialUnits.flippingY(rotation).act(point * flip)))
    }

    @Test("invalid points per meter use the default")
    func pointsPerMeter() {
        #expect(SpatialUnits.pointsPerMeter(250) == 250)
        for value: CGFloat in [0, -1, .nan, .infinity] {
            #expect(SpatialUnits.pointsPerMeter(value) == SpatialUnits.defaultPointsPerMeter)
        }
    }
}
