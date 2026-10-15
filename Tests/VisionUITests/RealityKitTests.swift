#if canImport(RealityKit)
import RealityKit
import simd
import Testing
@testable import VisionUI

@MainActor
@Suite("RealityKit arrangement")
struct RealityKitTests {
    func parent(withChildren count: Int) -> Entity {
        let parent = Entity()
        for _ in 0..<count { parent.addChild(Entity()) }
        return parent
    }

    @Test("children move to the layout's placements, in order")
    func arrangesChildren() {
        let parent = parent(withChildren: 5)
        let layout = RingLayout(radius: 0.3)
        #expect(parent.arrangeChildren(using: layout) == 5)
        for (child, placement) in zip(parent.children, layout.placements(count: 5)) {
            #expect(isClose(child.position, placement.position))
            #expect(isSameRotation(child.orientation, placement.orientation))
        }
    }

    @Test("children keep their scale")
    func keepsScale() {
        let parent = parent(withChildren: 2)
        parent.children[1].scale = SIMD3<Float>(repeating: 3)
        parent.arrangeChildren(using: ArcLayout(radius: 1, spacing: 0.5))
        #expect(parent.children[0].scale == SIMD3<Float>(repeating: 1))
        #expect(parent.children[1].scale == SIMD3<Float>(repeating: 3))
    }

    @Test("placements are relative to the parent, wherever it is")
    func relativeToParent() {
        let parent = parent(withChildren: 3)
        parent.position = SIMD3<Float>(2, 1, -1)
        parent.orientation = SpatialMath.yawRotation(.pi / 2)
        let layout = GridLayout(columns: 3, rows: 1, spacing: [0.5, 0, 0])
        parent.arrangeChildren(using: layout)
        #expect(isClose(parent.children[2].position, SIMD3<Float>(0.5, 0, 0)))
        // In world space the parent's quarter turn maps +x to -z.
        #expect(isClose(parent.children[2].position(relativeTo: nil), SIMD3<Float>(2, 1, -1.5)))
    }

    @Test("entities with different parents are placed in the reference's space")
    func arrangeAcrossParents() {
        let reference = Entity()
        reference.position = SIMD3<Float>(0, 2, 0)
        let first = Entity()
        let second = Entity()
        Entity().addChild(first)
        Entity().addChild(second)
        Entity.arrange([first, second], using: GridLayout(columns: 2, rows: 1, spacing: [1, 0, 0]), relativeTo: reference)
        #expect(isClose(first.position(relativeTo: nil), SIMD3<Float>(-0.5, 2, 0)))
        #expect(isClose(second.position(relativeTo: reference), SIMD3<Float>(0.5, 0, 0)))
    }

    @Test("bad durations place at once instead of animating")
    func badDurations() {
        for duration in [0, -1, .nan, .infinity] as [Double] {
            let parent = parent(withChildren: 2)
            parent.arrangeChildren(using: GridLayout(columns: 2, rows: 1, spacing: [1, 0, 0]), duration: duration)
            #expect(isClose(parent.children[0].position, SIMD3<Float>(-0.5, 0, 0)))
        }
    }

    @Test("Transform(placement) copies position and orientation")
    func transform() {
        let placement = SpatialPlacement(position: [1, 2, 3], orientation: SpatialMath.yawRotation(0.5))
        let transform = Transform(placement, scale: [2, 2, 2])
        #expect(transform.translation == placement.position)
        #expect(isSameRotation(transform.rotation, placement.orientation))
        #expect(transform.scale == [2, 2, 2])
    }

    /// A custom layout with a bug: every placement is broken.
    struct BrokenLayout: SpatialLayout {
        func placements(count: Int) -> [SpatialPlacement] {
            Array(repeating: SpatialPlacement(position: [.nan, .infinity, 1], orientation: simd_quatf(vector: [.infinity, 0, 0, 0])), count: SpatialLayoutLimits.clampedCount(count))
        }
    }

    @Test("a broken custom layout cannot give an entity an infinite transform")
    func brokenLayout() {
        let parent = parent(withChildren: 2)
        parent.arrangeChildren(using: BrokenLayout())
        for child in parent.children {
            #expect(child.position == [0, SpatialLayoutLimits.maximumLength, 1])
            #expect(child.orientation == SpatialMath.identity)
        }
        let entity = Entity()
        entity.apply(SpatialPlacement(position: [.nan, 0, 0], orientation: simd_quatf(vector: .zero)))
        #expect(entity.position == .zero)
    }

    @Test("an empty parent places nothing")
    func empty() {
        #expect(Entity().arrangeChildren(using: SphereLayout()) == 0)
    }
}
#endif
