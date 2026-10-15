import SwiftUI
import VisionUI

/// The layouts the gallery can show, with the settings it uses for each.
enum LayoutKind: String, CaseIterable, Identifiable {
    case arc = "Arc"
    case ring = "Ring"
    case grid = "Grid"
    case sphere = "Sphere"
    case helix = "Helix"

    var id: String { rawValue }

    /// The layout, sized to fit a volume about 1 m across.
    var layout: any SpatialLayout {
        switch self {
        case .arc: ArcLayout(radius: 0.45, spacing: 0.12, maximumAngle: .pi * 0.9)
        case .ring: RingLayout(radius: 0.32)
        case .grid: GridLayout(columns: 4, rows: 3, spacing: [0.14, 0.14, 0.14])
        case .sphere: SphereLayout(radius: 0.28)
        case .helix: HelixLayout(radius: 0.26, rise: 0.025, itemsPerTurn: 9)
        }
    }

    /// One sentence about the layout for the gallery.
    var summary: String {
        switch self {
        case .arc: "A curve that bends toward the viewer, items 12 cm apart."
        case .ring: "A closed circle, every item facing out."
        case .grid: "Four columns, three rows, then layers behind."
        case .sphere: "A Fibonacci spiral: each item covers the same area."
        case .helix: "Nine items per turn, rising 2.5 cm each."
        }
    }
}

/// The kit's blue palette, for tiles and diagrams.
enum Palette {
    static let blues: [Color] = [
        Color(red: 0, green: 0.443, blue: 0.890),       // #0071E3
        Color(red: 0.039, green: 0.518, blue: 1),       // #0A84FF
        Color(red: 0, green: 0.345, blue: 0.831),       // #0058D4
        Color(red: 0.353, green: 0.784, blue: 0.980),   // #5AC8FA
        Color(red: 0.392, green: 0.824, blue: 1),       // #64D2FF
    ]

    static func blue(_ index: Int) -> Color {
        blues[((index % blues.count) + blues.count) % blues.count]
    }
}

/// A numbered tile for the layout pages.
struct Tile: View {
    let index: Int
    var side: CGFloat = 64

    var body: some View {
        Text("\(index + 1)")
            .font(.system(size: side * 0.4, weight: .bold).monospacedDigit())
            .foregroundStyle(.white)
            .frame(width: side, height: side)
            .background(Palette.blue(index).gradient, in: .rect(cornerRadius: side * 0.22))
    }
}

/// The placements of a layout drawn from above (x and z) and from the front (x and y), with an
/// arrow for the direction each item faces. The README's layout images are rendered from it.
struct LayoutDiagram: View {
    let layout: any SpatialLayout
    let count: Int
    var foreground: Color = .primary

    var body: some View {
        let placements = layout.placements(count: count)
        HStack(spacing: 24) {
            panel("Top", placements: placements) { SIMD2($0.x, -$0.z) }
            panel("Front", placements: placements) { SIMD2($0.x, $0.y) }
        }
    }

    /// One view of the placements; `project` maps a 3D point to the panel's x and y (y up).
    private func panel(_ title: String, placements: [SpatialPlacement], project: @escaping (SIMD3<Float>) -> SIMD2<Float>) -> some View {
        VStack(spacing: 8) {
            Canvas { context, size in
                let points = placements.map { project($0.position) }
                let extent = max(points.map { max(abs($0.x), abs($0.y)) }.max() ?? 0, 0.05) * 1.25
                let scale = Float(min(size.width, size.height)) / (2 * extent)
                func point(_ value: SIMD2<Float>) -> CGPoint {
                    CGPoint(x: size.width / 2 + CGFloat(value.x * scale), y: size.height / 2 - CGFloat(value.y * scale))
                }
                // Axes through the origin.
                var axes = Path()
                axes.move(to: CGPoint(x: 0, y: size.height / 2))
                axes.addLine(to: CGPoint(x: size.width, y: size.height / 2))
                axes.move(to: CGPoint(x: size.width / 2, y: 0))
                axes.addLine(to: CGPoint(x: size.width / 2, y: size.height))
                context.stroke(axes, with: .color(foreground.opacity(0.15)), lineWidth: 1)

                for (index, placement) in placements.enumerated() {
                    let center = point(points[index])
                    let tip = project(placement.position + placement.forward * extent * 0.18)
                    var arrow = Path()
                    arrow.move(to: center)
                    arrow.addLine(to: point(tip))
                    context.stroke(arrow, with: .color(Palette.blue(index).opacity(0.8)), lineWidth: 2)
                    let dot = CGRect(x: center.x - 5, y: center.y - 5, width: 10, height: 10)
                    context.fill(Path(ellipseIn: dot), with: .color(Palette.blue(index)))
                }
            }
            .frame(width: 220, height: 220)
            Text(title)
                .font(.caption)
                .foregroundStyle(foreground.opacity(0.7))
        }
    }
}
