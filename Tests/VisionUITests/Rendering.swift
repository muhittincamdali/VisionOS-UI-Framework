#if !os(visionOS)
import CoreGraphics
import SwiftUI
import Testing

/// An opaque sRGB color with 8-bit channels, as read back from a rendered view.
struct RGB: Equatable, CustomStringConvertible {
    var red: Int
    var green: Int
    var blue: Int

    var description: String { "RGB(\(red), \(green), \(blue))" }

    func isClose(to other: RGB, tolerance: Int = 8) -> Bool {
        abs(red - other.red) <= tolerance && abs(green - other.green) <= tolerance && abs(blue - other.blue) <= tolerance
    }

    static let red = RGB(red: 255, green: 0, blue: 0)
    static let green = RGB(red: 0, green: 255, blue: 0)
    static let blue = RGB(red: 0, green: 0, blue: 255)
    static let white = RGB(red: 255, green: 255, blue: 255)
}

/// A view rendered with `ImageRenderer` at scale 1 over white, so one pixel is one point.
/// Row 0 is the top.
struct Pixels {
    let width: Int
    let height: Int
    private let bytes: [UInt8]

    @MainActor
    init(_ view: some View, width: Int, height: Int) throws {
        let renderer = ImageRenderer(content: ZStack { Color.white; view }.frame(width: CGFloat(width), height: CGFloat(height)))
        renderer.scale = 1
        let image = try #require(renderer.cgImage, "ImageRenderer produced no image")
        var bytes = [UInt8](repeating: 0, count: width * height * 4)
        let space = try #require(CGColorSpace(name: CGColorSpace.sRGB))
        let drawn = bytes.withUnsafeMutableBytes { buffer -> Bool in
            guard let context = CGContext(
                data: buffer.baseAddress, width: width, height: height, bitsPerComponent: 8,
                bytesPerRow: width * 4, space: space, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else { return false }
            context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            return true
        }
        try #require(drawn, "Could not create a bitmap context")
        self.width = width
        self.height = height
        self.bytes = bytes
    }

    subscript(x: Int, y: Int) -> RGB {
        let index = (y * width + x) * 4
        return RGB(red: Int(bytes[index]), green: Int(bytes[index + 1]), blue: Int(bytes[index + 2]))
    }
}

extension Color {
    // SwiftUI's `.red`, `.green` and `.blue` are system colors that differ between OS versions.
    static let pureRed = Color(.sRGB, red: 1, green: 0, blue: 0)
    static let pureGreen = Color(.sRGB, red: 0, green: 1, blue: 0)
    static let pureBlue = Color(.sRGB, red: 0, green: 0, blue: 1)
}

/// An opaque square of one color, for finding where a layout put it.
func swatch(_ color: Color, side: CGFloat = 20) -> some View {
    color.frame(width: side, height: side)
}
#endif
