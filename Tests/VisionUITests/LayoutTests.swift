import Foundation
import simd
import Testing
@testable import VisionUI

@Suite("Arc layout")
struct ArcLayoutTests {
    @Test("items sit on the circle and face its center")
    func onCircle() {
        let layout = ArcLayout(radius: 1.2, spacing: 0.3)
        let center = SIMD3<Float>(0, 0, 1.2)
        for placement in layout.placements(count: 7) {
            #expect(isClose(simd_distance(placement.position, center), 1.2))
            #expect(isClose(placement.forward, simd_normalize(center - placement.position)))
        }
    }

    @Test("the middle item is at the origin and the arc is symmetric")
    func symmetric() {
        let placements = ArcLayout(radius: 1, spacing: 0.25).placements(count: 5)
        #expect(isClose(placements[2].position, .zero))
        #expect(isClose(placements[2].forward, SIMD3<Float>(0, 0, 1)))
        for index in 0..<2 {
            let mirrored = placements[4 - index].position
            #expect(isClose(placements[index].position, SIMD3<Float>(-mirrored.x, mirrored.y, mirrored.z)))
        }
        // Outer items bend toward the viewer.
        #expect(placements[0].position.z > placements[1].position.z)
        #expect(placements[1].position.z > 0)
    }

    @Test("neighbors are `spacing` apart along the arc")
    func spacingAlongArc() {
        let layout = ArcLayout(radius: 2, spacing: 0.4)
        let placements = layout.placements(count: 4)
        let step = layout.angleStep(count: 4)
        #expect(isClose(step * 2, 0.4))
        for index in 1..<placements.count {
            // Chord length for an arc of `step` radians.
            let chord = 2 * 2 * sin(step / 2)
            #expect(isClose(simd_distance(placements[index].position, placements[index - 1].position), chord))
        }
    }

    @Test("spacing shrinks to fit the maximum angle")
    func maximumAngle() {
        let layout = ArcLayout(radius: 0.5, spacing: 0.5, maximumAngle: .pi / 2)
        #expect(isClose(layout.angleStep(count: 11), (.pi / 2) / 10))
        let placements = layout.placements(count: 11)
        let first = placements[0].position
        let last = placements[10].position
        // The two ends are π/2 apart around the center (0, 0, 0.5).
        let center = SIMD3<Float>(0, 0, 0.5)
        let angle = acos(simd_dot(simd_normalize(first - center), simd_normalize(last - center)))
        #expect(isClose(angle, .pi / 2, within: 1e-3))
    }

    @Test("forward facing keeps every item square to the viewer")
    func forwardFacing() {
        for placement in ArcLayout(facing: .forward).placements(count: 6) {
            #expect(placement.orientation == SpatialMath.identity)
        }
        for placement in ArcLayout(facing: .outward).placements(count: 6) {
            let center = SIMD3<Float>(0, 0, 1)
            #expect(isClose(placement.forward, simd_normalize(placement.position - center)))
        }
    }

    @Test("bad arguments give finite placements")
    func hostileArguments() {
        for value in hostileFloats {
            let layout = ArcLayout(radius: value, spacing: value, maximumAngle: value)
            let placements = layout.placements(count: 9)
            #expect(placements.count == 9)
            #expect(placements.allSatisfy(isFinite))
        }
        #expect(ArcLayout(radius: .nan).effectiveRadius == 1)
        #expect(ArcLayout(radius: -3).effectiveRadius == ArcLayout.minimumRadius)
        #expect(ArcLayout(radius: .infinity).effectiveRadius == SpatialLayoutLimits.maximumLength)
    }
}

@Suite("Ring layout")
struct RingLayoutTests {
    @Test("items are evenly spaced on the circle, the first at the front")
    func evenlySpaced() {
        let placements = RingLayout(radius: 0.4).placements(count: 8)
        #expect(isClose(placements[0].position, SIMD3<Float>(0, 0, 0.4)))
        #expect(isClose(placements[2].position, SIMD3<Float>(0.4, 0, 0)))
        let chord = simd_distance(placements[0].position, placements[1].position)
        for index in 0..<8 {
            let next = placements[(index + 1) % 8].position
            #expect(isClose(simd_length(placements[index].position), 0.4))
            #expect(isClose(simd_distance(placements[index].position, next), chord))
            #expect(isClose(placements[index].forward, simd_normalize(placements[index].position)))
        }
    }

    @Test("facing center turns every item inward")
    func inward() {
        for placement in RingLayout(radius: 1, facing: .center).placements(count: 5) {
            #expect(isClose(placement.forward, -simd_normalize(placement.position)))
        }
    }

    @Test("frontIndex finds the item nearest the front", arguments: [3, 4, 7, 12])
    func frontIndex(count: Int) {
        let step = RingLayout.angleStep(count: count)
        for index in 0..<count {
            let rotation = -Float(index) * step
            #expect(RingLayout(rotation: rotation).frontIndex(count: count) == index)
            // A little off still picks the same item.
            #expect(RingLayout(rotation: rotation + step * 0.3).frontIndex(count: count) == index)
            #expect(RingLayout(rotation: rotation - step * 0.3 + 6 * .pi).frontIndex(count: count) == index)
        }
    }

    @Test("rotation(bringingToFront:) turns the short way and lands on the item")
    func shortestTurn() {
        let count = 6
        let step = RingLayout.angleStep(count: count)
        for current: Float in [0, 0.4, -7.5, 20 * Float.pi, -13] {
            for index in -count..<(2 * count) {
                let target = RingLayout.rotation(bringingToFront: index, count: count, from: current)
                #expect(abs(target - current) <= .pi + 1e-3)
                let expected = ((index % count) + count) % count
                #expect(RingLayout(rotation: target).frontIndex(count: count) == expected)
            }
        }
        #expect(isClose(RingLayout.snappedRotation(step * 1.4, count: count), step))
    }

    @Test("extreme rotations and counts stay finite")
    func hostileArguments() {
        for value in hostileFloats {
            let ring = RingLayout(radius: value, rotation: value)
            #expect(ring.placements(count: 5).allSatisfy(isFinite))
            #expect((0..<5).contains(ring.frontIndex(count: 5)))
            #expect(RingLayout.rotation(bringingToFront: 2, count: 5, from: value).isFinite)
            #expect(RingLayout.snappedRotation(value, count: 5).isFinite)
        }
        #expect(RingLayout.rotation(bringingToFront: Int.min, count: 5, from: 0).isFinite)
        #expect(RingLayout.rotation(bringingToFront: Int.max, count: Int.max, from: 0).isFinite)
        #expect(RingLayout().frontIndex(count: 0) == 0)
        #expect(RingLayout().frontIndex(count: -4) == 0)
        #expect(RingLayout.angleStep(count: 0) == 0)
    }
}

@Suite("Grid layout")
struct GridLayoutTests {
    @Test("a partly filled row is centered on its items")
    func partialRow() {
        let placements = GridLayout(columns: 4, rows: 3, spacing: [0.2, 0.3, 0.1]).placements(count: 3)
        #expect(placements.map(\.position) == [[-0.2, 0, 0], [0, 0, 0], [0.2, 0, 0]])
    }

    @Test("full layers are centered and stack away from the viewer")
    func layers() {
        let placements = GridLayout(columns: 2, rows: 2, spacing: [1, 1, 1]).placements(count: 8)
        let mean = placements.map(\.position).reduce(.zero, +) / 8
        #expect(isClose(mean, .zero))
        #expect(placements[0].position == [-0.5, 0.5, 0.5])
        #expect(placements[3].position == [0.5, -0.5, 0.5])
        #expect(placements[4].position == [-0.5, 0.5, -0.5])
        #expect(placements.allSatisfy { $0.orientation == SpatialMath.identity })
    }

    @Test("cell(at:) matches the fill order")
    func cells() {
        let grid = GridLayout(columns: 3, rows: 2)
        #expect(grid.cell(at: 0)! == (0, 0, 0))
        #expect(grid.cell(at: 4)! == (1, 1, 0))
        #expect(grid.cell(at: 7)! == (1, 0, 1))
        #expect(grid.cell(at: -1) == nil)
        #expect(grid.cell(at: SpatialLayoutLimits.maximumItemCount) == nil)
    }

    @Test("huge or invalid column and row counts neither trap nor overflow")
    func hostileCounts() {
        for (columns, rows) in [(Int.max, Int.max), (0, 0), (-5, Int.min), (Int.max, 1)] {
            let grid = GridLayout(columns: columns, rows: rows, spacing: [.nan, .infinity, -1])
            let placements = grid.placements(count: 50)
            #expect(placements.count == 50)
            #expect(placements.allSatisfy(isFinite))
            #expect(grid.cell(at: 49) != nil)
        }
        // Zero columns become one: a vertical stack.
        let stack = GridLayout(columns: 0, rows: 10, spacing: [1, 1, 1]).placements(count: 3)
        #expect(stack.map(\.position.x) == [0, 0, 0])
    }
}

@Suite("Sphere layout")
struct SphereLayoutTests {
    @Test("points lie on the sphere, top first, facing out")
    func onSphere() {
        let placements = SphereLayout(radius: 0.3).placements(count: 120)
        for placement in placements {
            #expect(isClose(simd_length(placement.position), 0.3))
            #expect(isClose(placement.forward, simd_normalize(placement.position)))
        }
        #expect(placements.first!.position.y > placements.last!.position.y)
        let heights = placements.map(\.position.y)
        #expect(heights == heights.sorted(by: >))
    }

    @Test("points are spread evenly, with no clusters")
    func evenSpread() {
        let count = 200
        let positions = SphereLayout(radius: 1).placements(count: count).map(\.position)
        let mean = positions.reduce(.zero, +) / Float(count)
        #expect(simd_length(mean) < 0.02)
        // Each point covers about 4π/n of the surface, so neighbors are about sqrt(4π/n) apart.
        let typical = sqrt(4 * Float.pi / Float(count))
        var closest = Float.infinity
        for i in 0..<count {
            for j in (i + 1)..<count { closest = min(closest, simd_distance(positions[i], positions[j])) }
        }
        #expect(closest > 0.6 * typical)
    }

    @Test("a single item sits on the equator, facing forward")
    func singleItem() {
        let placement = SphereLayout(radius: 2).placements(count: 1)[0]
        #expect(isClose(placement.position, SIMD3<Float>(0, 0, 2)))
        #expect(isClose(placement.forward, SIMD3<Float>(0, 0, 1)))
    }

    @Test("bad radii give finite placements")
    func hostileRadius() {
        for value in hostileFloats {
            #expect(SphereLayout(radius: value, facing: .center).placements(count: 30).allSatisfy(isFinite))
        }
    }
}

@Suite("Helix layout")
struct HelixLayoutTests {
    @Test("items rise evenly around the axis and are centered vertically")
    func rising() {
        let placements = HelixLayout(radius: 0.5, rise: 0.1, itemsPerTurn: 4).placements(count: 9)
        #expect(isClose(placements[4].position.y, 0))
        for index in 1..<9 {
            #expect(isClose(placements[index].position.y - placements[index - 1].position.y, 0.1))
            let horizontal = SIMD2<Float>(placements[index].position.x, placements[index].position.z)
            #expect(isClose(simd_length(horizontal), 0.5))
        }
        // Four items per turn: item 4 is straight above item 0.
        #expect(isClose(placements[4].position.x, placements[0].position.x))
        #expect(isClose(placements[1].position, SIMD3<Float>(0.5, -0.3, 0)))
    }

    @Test("bad arguments give finite placements")
    func hostileArguments() {
        for value in hostileFloats {
            let placements = HelixLayout(radius: value, rise: value, itemsPerTurn: value).placements(count: 40)
            #expect(placements.count == 40)
            #expect(placements.allSatisfy(isFinite))
        }
    }
}

@Suite("Layout limits")
struct LayoutLimitTests {
    static let layouts: [any SpatialLayout] = [
        ArcLayout(), RingLayout(), GridLayout(), SphereLayout(), HelixLayout(),
    ]

    @Test("counts are clamped, so a huge count cannot exhaust memory")
    func clampedCounts() {
        for layout in Self.layouts {
            #expect(layout.placements(count: 0).isEmpty)
            #expect(layout.placements(count: -1).isEmpty)
            #expect(layout.placements(count: Int.min).isEmpty)
            #expect(layout.placements(count: Int.max).count == SpatialLayoutLimits.maximumItemCount)
        }
    }

    @Test("the largest layouts stay finite")
    func largestLayouts() {
        let largest: [any SpatialLayout] = [
            ArcLayout(radius: .infinity, spacing: .infinity, maximumAngle: .infinity),
            GridLayout(columns: 1, rows: 1, spacing: [.infinity, .infinity, .infinity]),
            HelixLayout(radius: .infinity, rise: .infinity, itemsPerTurn: .infinity),
            HelixLayout(radius: 1, rise: -.infinity, itemsPerTurn: 1),
        ]
        for layout in largest {
            #expect(layout.placements(count: Int.max).allSatisfy(isFinite))
        }
    }

    @Test("static shorthands build the same layouts")
    func shorthands() {
        #expect(ArcLayout.arc(radius: 2, spacing: 0.1) == ArcLayout(radius: 2, spacing: 0.1))
        #expect(RingLayout.ring(radius: 1, rotation: 0.5) == RingLayout(radius: 1, rotation: 0.5))
        #expect(GridLayout.grid(columns: 2, rows: 2) == GridLayout(columns: 2, rows: 2))
        #expect(SphereLayout.sphere(radius: 3) == SphereLayout(radius: 3))
        #expect(HelixLayout.helix(rise: 0.2) == HelixLayout(rise: 0.2))
    }
}
