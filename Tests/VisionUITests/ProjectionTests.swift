import CoreGraphics
import SwiftUI
import simd
import Testing
@testable import VisionUI

@Suite("Flat projection")
struct FlatProjectionTests {
    @Test("x and y become points, with y pointing down")
    func offsets() {
        let projected = FlatProjection(pointsPerMeter: 100).project(SpatialPlacement(position: [0.5, 0.25, 0]))
        #expect(projected.offset == CGSize(width: 50, height: -25))
        #expect(projected.scale == 1)
        #expect(projected.zIndex == 0)
    }

    @Test("nearer items are drawn larger and on top")
    func depth() {
        let projection = FlatProjection(viewerDistance: 2)
        let near = projection.project(SpatialPlacement(position: [0, 0, 1]))
        let far = projection.project(SpatialPlacement(position: [0, 0, -2]))
        #expect(near.scale == 2)
        #expect(far.scale == 0.5)
        #expect(near.zIndex > far.zIndex)
    }

    @Test("items at or behind the viewer get the largest scale, not infinity")
    func behindViewer() {
        let projection = FlatProjection(viewerDistance: 1)
        for z: Float in [1, 5, .infinity, .nan] {
            let projected = projection.project(SpatialPlacement(position: [0, 0, z]))
            #expect(projected.scale.isFinite)
            #expect(FlatProjection.scaleRange.contains(projected.scale))
        }
    }

    @Test("bad settings fall back to the defaults")
    func hostileSettings() {
        let placement = SpatialPlacement(position: [1, 0, 0])
        for points: CGFloat in [0, -10, .nan, .infinity] {
            #expect(FlatProjection(pointsPerMeter: points, viewerDistance: .nan).project(placement).offset.width == 1000)
        }
        let far = FlatProjection().project(SpatialPlacement(position: [.greatestFiniteMagnitude, -.greatestFiniteMagnitude, 0]))
        #expect(far.offset.width.isFinite && far.offset.height.isFinite)
    }

    @Test("a huge points-per-meter value is capped, so offsets stay finite")
    func hugeScale() {
        // Without the cap the offset limit, 10 km times the scale, overflowed to infinity.
        let projection = FlatProjection(pointsPerMeter: .greatestFiniteMagnitude)
        #expect(projection.project(SpatialPlacement(position: [1, -2, 0])).offset == CGSize(width: 1_000_000, height: 2_000_000))
        let far = projection.project(SpatialPlacement(position: [.greatestFiniteMagnitude, 0, 0]))
        #expect(far.offset == CGSize(width: 1e10, height: 0))
        #expect(SpatialUnits.pointsPerMeter(5_000_000) == SpatialUnits.maximumPointsPerMeter)
        #expect(SpatialUnits.pointsPerMeter(250) == 250)
    }

    @Test("the yaw comes from the placement's orientation")
    func yaw() {
        let projected = FlatProjection().project(SpatialPlacement(position: .zero, orientation: SpatialMath.yawRotation(0.5)))
        #expect(abs(projected.yaw - 0.5) < 1e-5)
    }
}

@Suite("Carousel")
struct CarouselTests {
    typealias Carousel = SpatialCarousel<[Int], Int, EmptyView>

    @Test("a drag the length of the radius turns the ring one radian")
    func dragRotation() {
        #expect(Carousel.rotation(from: 0.5, dragged: 200, radiusInPoints: 200) == 1.5)
        #expect(Carousel.rotation(from: 0, dragged: -100, radiusInPoints: 400) == -0.25)
    }

    @Test("a zero radius or bad values leave the rotation as it was")
    func hostileDrag() {
        #expect(Carousel.rotation(from: 0.5, dragged: 200, radiusInPoints: 0) == 0.5)
        #expect(Carousel.rotation(from: 0.5, dragged: .nan, radiusInPoints: 200) == 0.5)
        #expect(Carousel.rotation(from: 0.5, dragged: 200, radiusInPoints: .infinity) == 0.5)
        #expect(Carousel.rotation(from: .nan, dragged: 200, radiusInPoints: 200) == 0)
        #expect(Carousel.rotation(from: .greatestFiniteMagnitude, dragged: .greatestFiniteMagnitude, radiusInPoints: 1e-2) == .greatestFiniteMagnitude)
    }

    @Test("stepping through the views wraps and never overflows")
    func stepping() {
        #expect(Carousel.stepped(4, by: 1, count: 5) == 0)
        #expect(Carousel.stepped(0, by: -1, count: 5) == 4)
        // Int.max = 9223372036854775807 is 2 modulo 5, and Int.min = -9223372036854775808 is 2 too
        // (-3 + 5), so these expected values do not depend on `wrapped(_:count:)`.
        #expect(Carousel.stepped(Int.max, by: 1, count: 5) == 3)
        #expect(Carousel.stepped(Int.min, by: -1, count: 5) == 1)
        #expect(Carousel.stepped(2, by: Int.min, count: 5) == 4)
        #expect(Carousel.stepped(Int.max, by: Int.max, count: 5) == 4)
        #expect(Carousel.stepped(3, by: 1, count: 0) == 0)
    }

    @Test("selection indices wrap around")
    func wrapping() {
        #expect(Carousel.wrapped(7, count: 5) == 2)
        #expect(Carousel.wrapped(-1, count: 5) == 4)
        #expect(Carousel.wrapped(Int.max, count: 5) == 2)
        #expect(Carousel.wrapped(Int.min, count: 5) == 2)
        #expect(Carousel.wrapped(3, count: 0) == 0)
    }
}
