#if os(macOS)
import Foundation
import ImageIO
import SwiftUI
import Testing
import UniformTypeIdentifiers
@testable import VisionUI

/// Renders the README's layout diagrams into `SCREENSHOT_DIR`. Run it with
/// scripts/generate-screenshots.sh; without the variable the suite is skipped.
@MainActor
@Suite("README images", .enabled(if: ProcessInfo.processInfo.environment["SCREENSHOT_DIR"] != nil))
struct Screenshots {
    let directory = URL(fileURLWithPath: ProcessInfo.processInfo.environment["SCREENSHOT_DIR"] ?? ".")

    /// The kit's page colors behind the diagrams.
    enum Appearance: String, CaseIterable {
        case light, dark

        var background: Color { self == .light ? srgb(245, 249, 255) : srgb(4, 17, 31) }
        var foreground: Color { self == .light ? srgb(4, 17, 31) : srgb(234, 244, 255) }
        var colorScheme: ColorScheme { self == .light ? .light : .dark }
    }

    @Test("Layout diagrams", arguments: Appearance.allCases)
    func layoutDiagrams(appearance: Appearance) throws {
        let page = VStack(alignment: .leading, spacing: 28) {
            ForEach(LayoutKind.allCases) { kind in
                HStack(spacing: 28) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(kind.rawValue)Layout")
                            .font(.system(size: 20, weight: .semibold, design: .monospaced))
                        Text(kind.summary)
                            .font(.system(size: 14))
                            .opacity(0.75)
                    }
                    .frame(width: 230, alignment: .leading)
                    LayoutDiagram(layout: kind.layout, count: 12, foreground: appearance.foreground)
                }
            }
        }
        .foregroundStyle(appearance.foreground)
        .padding(32)
        .background(appearance.background)
        .environment(\.colorScheme, appearance.colorScheme)
        try writePNG(page, name: "layouts-\(appearance.rawValue)")
    }

    private func writePNG(_ view: some View, name: String) throws {
        let renderer = ImageRenderer(content: view)
        renderer.scale = 2
        let image = try #require(renderer.cgImage)
        let url = directory.appendingPathComponent("\(name).png")
        let destination = try #require(CGImageDestinationCreateWithURL(url as CFURL, UTType.png.identifier as CFString, 1, nil))
        CGImageDestinationAddImage(destination, image, nil)
        #expect(CGImageDestinationFinalize(destination))
    }
}

private func srgb(_ red: Int, _ green: Int, _ blue: Int) -> Color {
    Color(.sRGB, red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255)
}
#endif
