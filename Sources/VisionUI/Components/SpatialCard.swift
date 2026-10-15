import SwiftUI

/// A rounded panel for grouping content, drawn with the platform's own background: glass on
/// visionOS and a material on iOS and macOS.
///
/// On visionOS the card lifts toward the person when they look at it, and can sit `depth` points
/// in front of its parent. On iOS and macOS the depth becomes a shadow.
///
/// ```swift
/// SpatialCard {
///     VStack(alignment: .leading) {
///         Text("Saturn").font(.title)
///         Text("Sixth planet from the Sun")
///     }
/// }
/// ```
public struct SpatialCard<Content: View>: View {
    private let cornerRadius: CGFloat
    private let padding: CGFloat
    private let depth: CGFloat
    private let liftsOnHover: Bool
    private let content: Content

    /// Creates a card.
    ///
    /// - Parameters:
    ///   - cornerRadius: The radius of the card's corners, in points. Negative or non-finite
    ///     values become `0`.
    ///   - padding: The space between the edge and the content, in points. Negative or non-finite
    ///     values become `0`.
    ///   - depth: How far in front of its parent the card sits, in points. See
    ///     ``View/spatialDepth(_:)``.
    ///   - liftsOnHover: Whether the card lifts when a person looks at it or points at it.
    ///   - content: The card's content.
    public init(
        cornerRadius: CGFloat = 32,
        padding: CGFloat = 24,
        depth: CGFloat = 0,
        liftsOnHover: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = HitTarget.sanitized(cornerRadius)
        self.padding = HitTarget.sanitized(padding)
        self.depth = depth
        self.liftsOnHover = liftsOnHover
        self.content = content()
    }

    public var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        content
            .padding(padding)
            .modifier(CardBackground(shape: shape))
            .contentShape(shape)
            .modifier(LiftOnHover(isEnabled: liftsOnHover))
            .spatialDepth(depth)
    }
}

private struct LiftOnHover: ViewModifier {
    let isEnabled: Bool

    func body(content: Content) -> some View {
        #if os(visionOS) || os(iOS)
        content.hoverEffect(.lift, isEnabled: isEnabled)
        #else
        content
        #endif
    }
}

private struct CardBackground: ViewModifier {
    let shape: RoundedRectangle

    func body(content: Content) -> some View {
        #if os(visionOS)
        content.glassBackgroundEffect(in: shape)
        #else
        content
            .background(.regularMaterial, in: shape)
            .overlay(shape.strokeBorder(.separator.opacity(0.6), lineWidth: 0.5))
        #endif
    }
}

public extension View {
    /// Moves the view `depth` points toward the viewer.
    ///
    /// On visionOS the view really moves in front of its parent, which keeps its layout. On iOS
    /// and macOS, where views have no depth, a soft shadow whose size grows with `depth` stands
    /// in for it. Zero, negative and non-finite values leave the view where it is.
    func spatialDepth(_ depth: CGFloat) -> some View {
        modifier(SpatialDepthModifier(depth: SpatialDepthModifier.sanitized(depth)))
    }
}

struct SpatialDepthModifier: ViewModifier {
    /// The largest depth the modifier applies, in points.
    static let maximumDepth: CGFloat = 1_000

    let depth: CGFloat

    static func sanitized(_ depth: CGFloat) -> CGFloat {
        min(HitTarget.sanitized(depth), maximumDepth)
    }

    func body(content: Content) -> some View {
        #if os(visionOS)
        content.offset(z: depth)
        #else
        content.shadow(color: .black.opacity(depth > 0 ? 0.18 : 0), radius: depth / 3, y: depth / 6)
        #endif
    }
}
