#if !os(visionOS)
import SwiftUI
import simd
import Testing
@testable import VisionUI

private struct Swatch: Identifiable {
    let id: Int
    let color: Color
}

private let primaries = [Swatch(id: 0, color: .pureRed), Swatch(id: 1, color: .pureGreen), Swatch(id: 2, color: .pureBlue)]

/// Renders the views on a flat screen and checks where the projection put them.
@MainActor
@Suite("Rendering on a flat screen")
struct RenderTests {
    @Test("SpatialLayoutView puts each view at its projected offset")
    func layoutViewOffsets() throws {
        // Three items 0.1 m apart at 1000 points per meter: 100 points apart around the center.
        let view = SpatialLayoutView(GridLayout(columns: 3, rows: 1, spacing: [0.1, 0, 0]), primaries) { item in
            swatch(item.color)
        }
        let pixels = try Pixels(view, width: 300, height: 60)
        #expect(pixels[50, 30].isClose(to: .red))
        #expect(pixels[150, 30].isClose(to: .green))
        #expect(pixels[250, 30].isClose(to: .blue))
        #expect(pixels[100, 30] == .white)
    }

    @Test("rows above the origin are drawn higher on screen")
    func verticalDirection() throws {
        let view = SpatialLayoutView(GridLayout(columns: 1, rows: 2, spacing: [0, 0.05, 0]), primaries.prefix(2)) { item in
            swatch(item.color)
        }
        let pixels = try Pixels(view, width: 60, height: 120)
        // The first row is at +y (up), 25 points above the center.
        #expect(pixels[30, 35].isClose(to: .red))
        #expect(pixels[30, 85].isClose(to: .green))
    }

    @Test("the item nearest the viewer is drawn on top and larger")
    func depthOrder() throws {
        // Two items on a small ring: the first at the front, the second behind it, both at x = 0.
        let view = SpatialLayoutView(RingLayout(radius: 0.2, facing: .forward), primaries.prefix(2), projection: FlatProjection(viewerDistance: 1)) { item in
            swatch(item.color)
        }
        let pixels = try Pixels(view, width: 100, height: 100)
        #expect(pixels[50, 50].isClose(to: .red))
        // The front item is drawn at 1 / (1 - 0.2) = 1.25 times its size: 25 points wide.
        #expect(pixels[39, 50].isClose(to: .red))
        #expect(pixels[36, 50] == .white)
    }

    @Test("a carousel shows the selected item at the front")
    func carouselSelection() throws {
        let view = SpatialCarousel(primaries, selection: .constant(2), radius: 0.15) { item in
            swatch(item.color, side: 40)
        }
        let pixels = try Pixels(view, width: 400, height: 120)
        #expect(pixels[200, 60].isClose(to: .blue))
        // The front item is in the carousel's plane, so it keeps its 40-point size.
        #expect(pixels[182, 60].isClose(to: .blue))
        #expect(pixels[177, 60] == .white)
    }

    @Test("a custom layout with broken placements still draws its views at finite positions")
    func brokenPlacements() throws {
        struct BrokenLayout: SpatialLayout {
            func placements(count: Int) -> [SpatialPlacement] {
                let placement = SpatialPlacement(position: [.nan, 0.025, 0], orientation: simd_quatf(vector: [.infinity, 0, 0, 1]))
                return Array(repeating: placement, count: max(count, 0))
            }
        }
        let view = SpatialLayoutView(BrokenLayout(), primaries.prefix(1)) { item in swatch(item.color) }
        let pixels = try Pixels(view, width: 60, height: 120)
        // Only the NaN coordinate becomes 0; the valid y keeps the swatch 25 points above the
        // center. Without sanitizing, the flat projection would drop the whole position and draw
        // the swatch in the middle. The infinite orientation becomes no rotation.
        #expect(pixels[30, 35].isClose(to: .red))
        #expect(pixels[30, 60] == .white)
    }

    @Test("spatialHitTarget keeps the view's layout size")
    func hitTargetLayout() throws {
        let row = HStack(spacing: 0) {
            swatch(.pureRed, side: 10).spatialHitTarget(minimum: 60)
            swatch(.pureBlue, side: 10)
        }
        let pixels = try Pixels(row.fixedSize(), width: 20, height: 10)
        #expect(pixels[5, 5].isClose(to: .red))
        #expect(pixels[15, 5].isClose(to: .blue))
    }

    @Test("spatialDepth leaves a view without depth untouched")
    func zeroDepth() throws {
        let pixels = try Pixels(swatch(.pureGreen, side: 30).spatialDepth(0), width: 40, height: 40)
        #expect(pixels[20, 20].isClose(to: .green))
        #expect(pixels[2, 2] == .white)
    }

    @Test("components render their content")
    func components() throws {
        let card = SpatialCard(padding: 10) { swatch(.pureBlue, side: 30) }
        let cardPixels = try Pixels(card, width: 80, height: 80)
        #expect(cardPixels[40, 40].isClose(to: .blue))

        let toolbar = Color.white.frame(width: 200, height: 120).toolbarOrnament(edge: .bottom) {
            Button("Play", systemImage: "play.fill") {}
        }
        let toolbarPixels = try Pixels(toolbar, width: 200, height: 120)
        // The toolbar is drawn over the bottom of the content; the top stays white.
        #expect(toolbarPixels[100, 10] == .white)
        #expect((0..<120).contains { y in toolbarPixels[100, y] != .white })
    }
}
#endif
