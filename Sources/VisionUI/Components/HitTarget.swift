import SwiftUI

/// The size of the area a person can tap, look at and pinch, or click.
///
/// Apple's Human Interface Guidelines give a default control size of 60 × 60 points on
/// visionOS, where people aim with their eyes, 44 × 44 points on iOS and 28 × 28 points on macOS.
/// ``SwiftUICore/View/spatialHitTarget(minimum:)`` grows a smaller view's tappable area to that size without
/// changing how it looks.
public enum HitTarget {
    /// The default control size on visionOS, in points.
    public static let visionOS: CGFloat = 60
    /// The default control size on iOS and iPadOS, in points.
    public static let iOS: CGFloat = 44
    /// The default control size on macOS, in points.
    public static let macOS: CGFloat = 28

    /// The default control size on the platform the app runs on.
    public static var platformDefault: CGFloat {
        #if os(visionOS)
        visionOS
        #elseif os(macOS)
        macOS
        #else
        iOS
        #endif
    }

    /// The padding on each side that grows a view of `size` to at least `minimum` on both axes.
    ///
    /// Sides that are already large enough get no padding. Values that are negative, NaN or
    /// infinite count as zero, and minimums above 10,000 points count as 10,000.
    public static func padding(toGrow size: CGSize, to minimum: CGFloat) -> EdgeInsets {
        let minimum = min(sanitized(minimum), largestMinimum)
        let horizontal = max(minimum - sanitized(size.width), 0) / 2
        let vertical = max(minimum - sanitized(size.height), 0) / 2
        return EdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// The largest minimum ``padding(toGrow:to:)`` grows a view to, in points. Far beyond any
    /// screen or window, and small enough that the padding stays a usable layout value.
    static let largestMinimum: CGFloat = 10_000

    static func sanitized(_ value: CGFloat) -> CGFloat {
        value.isFinite && value > 0 ? value : 0
    }
}

public extension View {
    /// Grows the view's tappable area to at least `minimum` points on each axis, centered on the
    /// view, without changing how the view looks or how it is laid out.
    ///
    /// ```swift
    /// Image(systemName: "xmark")
    ///     .onTapGesture(perform: close)
    ///     .spatialHitTarget()
    /// ```
    ///
    /// On visionOS the system's hover highlight follows the grown area, so the person sees what
    /// they are about to select.
    ///
    /// - Parameter minimum: The smallest width and height of the tappable area, in points. The
    ///   default is the platform's default control size from ``HitTarget``. Values above 10,000
    ///   count as 10,000.
    func spatialHitTarget(minimum: CGFloat = HitTarget.platformDefault) -> some View {
        modifier(HitTargetModifier(minimum: minimum))
    }
}

struct HitTargetModifier: ViewModifier {
    let minimum: CGFloat
    @State private var size: CGSize = .zero

    func body(content: Content) -> some View {
        let insets = HitTarget.padding(toGrow: size, to: minimum)
        content
            .onGeometryChange(for: CGSize.self, of: \.size) { size = $0 }
            .padding(insets)
            .modifier(HoverShape())
            .contentShape(Rectangle())
            .padding(EdgeInsets(top: -insets.top, leading: -insets.leading, bottom: -insets.bottom, trailing: -insets.trailing))
    }
}

/// Makes the visionOS and iPadOS hover highlight cover the whole grown area.
private struct HoverShape: ViewModifier {
    func body(content: Content) -> some View {
        #if os(visionOS) || os(iOS)
        content.contentShape(.hoverEffect, Rectangle())
        #else
        content
        #endif
    }
}
