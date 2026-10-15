import SwiftUI

/// A row of controls on a capsule, sized for the platform: glass with 60-point targets on
/// visionOS, a material with 44- or 28-point targets on iOS and macOS.
///
/// Use it on its own, or attach it to the edge of a window with
/// ``SwiftUICore/View/toolbarOrnament(edge:content:)``.
///
/// ```swift
/// SpatialToolbar {
///     Button("Previous", systemImage: "chevron.left", action: previous)
///     Button("Play", systemImage: "play.fill", action: play)
///     Button("Next", systemImage: "chevron.right", action: next)
/// }
/// ```
///
/// Buttons in the toolbar show only their icons, keep their titles for VoiceOver, and get the
/// platform's default control size from ``HitTarget``.
public struct SpatialToolbar<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    /// Creates a toolbar.
    ///
    /// - Parameters:
    ///   - spacing: The space between controls, in points.
    ///   - content: The controls.
    public init(spacing: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.spacing = HitTarget.sanitized(spacing)
        self.content = content()
    }

    public var body: some View {
        HStack(spacing: spacing) {
            content
                .labelStyle(.iconOnly)
                .buttonStyle(SpatialToolbarButtonStyle())
        }
        .padding(spacing)
        .modifier(ToolbarBackground())
    }
}

/// The style of the buttons in a ``SpatialToolbar``: a circle of the platform's default control
/// size that highlights when pressed and, on visionOS, when looked at.
public struct SpatialToolbarButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    /// Creates the style.
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .frame(minWidth: HitTarget.platformDefault, minHeight: HitTarget.platformDefault)
            .background(.primary.opacity(configuration.isPressed ? 0.18 : 0), in: Circle())
            .contentShape(Circle())
            .opacity(isEnabled ? 1 : 0.4)
            .modifier(CircleHover())
    }
}

private struct CircleHover: ViewModifier {
    func body(content: Content) -> some View {
        #if os(visionOS) || os(iOS)
        content.hoverEffect(.highlight)
        #else
        content
        #endif
    }
}

private struct ToolbarBackground: ViewModifier {
    func body(content: Content) -> some View {
        #if os(visionOS)
        content.glassBackgroundEffect(in: Capsule())
        #else
        content
            .background(.regularMaterial, in: Capsule())
            .overlay(Capsule().strokeBorder(.separator.opacity(0.6), lineWidth: 0.5))
        #endif
    }
}

/// The edge of a window that a toolbar ornament is attached to.
public enum OrnamentEdge: Sendable, CaseIterable {
    /// Below the window, centered.
    case bottom
    /// Above the window, centered.
    case top
    /// Left of the window, centered vertically.
    case leading
    /// Right of the window, centered vertically.
    case trailing

    /// The point on the window's edge that the ornament attaches to.
    var anchor: UnitPoint {
        switch self {
        case .bottom: .bottom
        case .top: .top
        case .leading: .leading
        case .trailing: .trailing
        }
    }

    /// Whether the toolbar runs vertically along this edge.
    var isVertical: Bool { self == .leading || self == .trailing }
}

public extension View {
    /// Attaches a ``SpatialToolbar`` to an edge of the window.
    ///
    /// On visionOS the toolbar is an ornament: it floats just outside the window, slightly in front
    /// of it, and moves with the window. On iOS and macOS it is drawn over the content at the same
    /// edge, inside the safe area, so one piece of code works on every platform.
    ///
    /// ```swift
    /// PhotoView(photo)
    ///     .toolbarOrnament(edge: .bottom) {
    ///         Button("Share", systemImage: "square.and.arrow.up", action: share)
    ///         Button("Delete", systemImage: "trash", role: .destructive, action: delete)
    ///     }
    /// ```
    ///
    /// For a leading or trailing edge the controls are stacked vertically.
    func toolbarOrnament<Content: View>(edge: OrnamentEdge = .bottom, @ViewBuilder content: () -> Content) -> some View {
        modifier(ToolbarOrnamentModifier(edge: edge, toolbar: OrnamentToolbar(edge: edge, content: content())))
    }
}

/// The toolbar, laid out along the edge.
struct OrnamentToolbar<Content: View>: View {
    let edge: OrnamentEdge
    let content: Content

    var body: some View {
        if edge.isVertical {
            SpatialToolbar { VStack(spacing: 8) { content } }
        } else {
            SpatialToolbar { content }
        }
    }
}

struct ToolbarOrnamentModifier<Toolbar: View>: ViewModifier {
    let edge: OrnamentEdge
    let toolbar: Toolbar

    func body(content: Content) -> some View {
        #if os(visionOS)
        // The alignment is spelled out per case: SDKs before visionOS 27 take an `Alignment` here
        // and later ones an `Alignment3D`, and `.top` and the others name a value of either type.
        switch edge {
        case .bottom: content.ornament(attachmentAnchor: .scene(.bottom), contentAlignment: .top) { toolbar }
        case .top: content.ornament(attachmentAnchor: .scene(.top), contentAlignment: .bottom) { toolbar }
        case .leading: content.ornament(attachmentAnchor: .scene(.leading), contentAlignment: .trailing) { toolbar }
        case .trailing: content.ornament(attachmentAnchor: .scene(.trailing), contentAlignment: .leading) { toolbar }
        }
        #else
        content.overlay(alignment: Alignment(horizontal: edge.anchor.horizontalAlignment, vertical: edge.anchor.verticalAlignment)) {
            toolbar.padding()
        }
        #endif
    }
}

extension UnitPoint {
    var horizontalAlignment: HorizontalAlignment {
        x < 0.5 ? .leading : (x > 0.5 ? .trailing : .center)
    }

    var verticalAlignment: VerticalAlignment {
        y < 0.5 ? .top : (y > 0.5 ? .bottom : .center)
    }
}
