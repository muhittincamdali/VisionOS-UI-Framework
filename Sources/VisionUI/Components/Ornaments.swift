// Ornaments.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI

// MARK: - Ornament System
/// A comprehensive ornament system for visionOS windows.
/// Ornaments are floating UI elements attached to the edges of windows.
///
/// Example:
/// ```swift
/// ContentView()
///     .ornament(edge: .bottom, alignment: .center) {
///         ToolbarOrnament(items: tools)
///     }
/// ```
@available(visionOS 2.0, *)
public struct OrnamentModifier<OrnamentContent: View>: ViewModifier {
    
    let edge: Edge
    let alignment: Alignment
    let ornamentContent: OrnamentContent
    let visibility: OrnamentVisibility
    let offset: CGFloat
    let contentAlignment: OrnamentContentAlignment
    
    public func body(content: Content) -> some View {
        content
            .ornament(
                visibility: visibility.swiftUIVisibility,
                attachmentAnchor: .scene(attachmentAnchor),
                contentAlignment: contentAlignment.swiftUIAlignment
            ) {
                ornamentContent
                    .padding(8)
                    .glassBackgroundEffect()
            }
    }
    
    private var attachmentAnchor: UnitPoint {
        switch edge {
        case .top:
            switch alignment {
            case .leading: return .topLeading
            case .trailing: return .topTrailing
            default: return .top
            }
        case .bottom:
            switch alignment {
            case .leading: return .bottomLeading
            case .trailing: return .bottomTrailing
            default: return .bottom
            }
        case .leading:
            switch alignment {
            case .top: return .topLeading
            case .bottom: return .bottomLeading
            default: return .leading
            }
        case .trailing:
            switch alignment {
            case .top: return .topTrailing
            case .bottom: return .bottomTrailing
            default: return .trailing
            }
        }
    }
}

// MARK: - Ornament Extensions

@available(visionOS 2.0, *)
extension View {
    /// Adds an ornament to the view.
    public func ornament<Content: View>(
        edge: Edge,
        alignment: Alignment = .center,
        visibility: OrnamentVisibility = .automatic,
        offset: CGFloat = 0,
        contentAlignment: OrnamentContentAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> some View {
        modifier(OrnamentModifier(
            edge: edge,
            alignment: alignment,
            ornamentContent: content(),
            visibility: visibility,
            offset: offset,
            contentAlignment: contentAlignment
        ))
    }
}

// MARK: - Ornament Visibility

/// Visibility options for ornaments.
public enum OrnamentVisibility {
    case automatic
    case visible
    case hidden
    
    var swiftUIVisibility: Visibility {
        switch self {
        case .automatic: return .automatic
        case .visible: return .visible
        case .hidden: return .hidden
        }
    }
}

// MARK: - Ornament Content Alignment

/// Content alignment options for ornaments.
public enum OrnamentContentAlignment {
    case center
    case leading
    case trailing
    case top
    case bottom
    
    var swiftUIAlignment: Alignment {
        switch self {
        case .center: return .center
        case .leading: return .leading
        case .trailing: return .trailing
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}

// MARK: - Toolbar Ornament

/// A toolbar ornament with action buttons.
@available(visionOS 2.0, *)
public struct ToolbarOrnament: View {
    
    private let items: [ToolbarItem]
    private var style: ToolbarOrnamentStyle = .capsule
    private var spacing: CGFloat = 12
    
    public init(items: [ToolbarItem]) {
        self.items = items
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(items) { item in
                ToolbarButton(item: item)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(toolbarBackground)
    }
    
    @ViewBuilder
    private var toolbarBackground: some View {
        switch style {
        case .capsule:
            Capsule()
                .fill(.ultraThinMaterial)
        case .roundedRectangle:
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        case .floating:
            EmptyView()
        }
    }
    
    /// Sets the toolbar style.
    public func style(_ style: ToolbarOrnamentStyle) -> ToolbarOrnament {
        var copy = self
        copy.style = style
        return copy
    }
    
    /// Sets the spacing between items.
    public func spacing(_ value: CGFloat) -> ToolbarOrnament {
        var copy = self
        copy.spacing = value
        return copy
    }
}

// MARK: - Toolbar Item

/// An item in a toolbar ornament.
public struct ToolbarItem: Identifiable {
    public let id = UUID()
    public let icon: String
    public let title: String
    public let action: () -> Void
    public var isEnabled: Bool = true
    public var badge: String?
    
    public init(
        icon: String,
        title: String,
        isEnabled: Bool = true,
        badge: String? = nil,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.isEnabled = isEnabled
        self.badge = badge
        self.action = action
    }
}

/// Toolbar ornament visual styles.
public enum ToolbarOrnamentStyle {
    case capsule
    case roundedRectangle
    case floating
}

// MARK: - Toolbar Button

@available(visionOS 2.0, *)
private struct ToolbarButton: View {
    let item: ToolbarItem
    
    @State private var isHovered: Bool = false
    
    var body: some View {
        Button(action: item.action) {
            VStack(spacing: 4) {
                ZStack {
                    Image(systemName: item.icon)
                        .font(.system(size: 20))
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .fill(isHovered ? Color.accentColor.opacity(0.2) : .clear)
                        )
                    
                    if let badge = item.badge {
                        Text(badge)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(Circle().fill(.red))
                            .offset(x: 16, y: -16)
                    }
                }
                
                Text(item.title)
                    .font(.caption2)
            }
        }
        .buttonStyle(.plain)
        .disabled(!item.isEnabled)
        .opacity(item.isEnabled ? 1 : 0.5)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
}

// MARK: - Tab Bar Ornament

/// A tab bar ornament for navigation.
@available(visionOS 2.0, *)
public struct TabBarOrnament<Selection: Hashable>: View {
    
    @Binding private var selection: Selection
    private let tabs: [TabItem<Selection>]
    private var style: TabBarStyle = .pills
    
    public init(
        selection: Binding<Selection>,
        tabs: [TabItem<Selection>]
    ) {
        self._selection = selection
        self.tabs = tabs
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(tabs) { tab in
                TabButton(
                    tab: tab,
                    isSelected: selection == tab.tag,
                    style: style
                ) {
                    withAnimation(.spring(response: 0.3)) {
                        selection = tab.tag
                    }
                }
            }
        }
        .padding(6)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
        )
    }
    
    /// Sets the tab bar style.
    public func style(_ style: TabBarStyle) -> TabBarOrnament {
        var copy = self
        copy.style = style
        return copy
    }
}

/// A tab item in a tab bar ornament.
public struct TabItem<Tag: Hashable>: Identifiable {
    public let id = UUID()
    public let icon: String
    public let title: String
    public let tag: Tag
    
    public init(icon: String, title: String, tag: Tag) {
        self.icon = icon
        self.title = title
        self.tag = tag
    }
}

/// Tab bar visual styles.
public enum TabBarStyle {
    case pills
    case underline
    case segmented
}

@available(visionOS 2.0, *)
private struct TabButton<Tag: Hashable>: View {
    let tab: TabItem<Tag>
    let isSelected: Bool
    let style: TabBarStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: tab.icon)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                
                if isSelected || style == .segmented {
                    Text(tab.title)
                        .font(.subheadline)
                        .fontWeight(isSelected ? .semibold : .regular)
                }
            }
            .foregroundStyle(isSelected ? .primary : .secondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(tabBackground)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var tabBackground: some View {
        switch style {
        case .pills:
            if isSelected {
                Capsule()
                    .fill(.regularMaterial)
            }
        case .underline:
            if isSelected {
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(height: 2)
                }
            }
        case .segmented:
            if isSelected {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.regularMaterial)
            }
        }
    }
}

// MARK: - Info Panel Ornament

/// An information panel ornament for displaying details.
@available(visionOS 2.0, *)
public struct InfoPanelOrnament<Content: View>: View {
    
    private let title: String
    private let content: Content
    @Binding private var isExpanded: Bool
    
    public init(
        title: String,
        isExpanded: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self._isExpanded = isExpanded
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: { withAnimation(.spring()) { isExpanded.toggle() } }) {
                HStack {
                    Text(title)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                content
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(16)
        .frame(width: 280)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }
}

// MARK: - Media Controls Ornament

/// A media player controls ornament.
@available(visionOS 2.0, *)
public struct MediaControlsOrnament: View {
    
    @Binding private var isPlaying: Bool
    @Binding private var progress: Double
    @Binding private var volume: Double
    
    private let onPrevious: () -> Void
    private let onNext: () -> Void
    
    public init(
        isPlaying: Binding<Bool>,
        progress: Binding<Double>,
        volume: Binding<Double>,
        onPrevious: @escaping () -> Void,
        onNext: @escaping () -> Void
    ) {
        self._isPlaying = isPlaying
        self._progress = progress
        self._volume = volume
        self.onPrevious = onPrevious
        self.onNext = onNext
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            // Progress bar
            ProgressBar(value: $progress)
            
            // Controls
            HStack(spacing: 24) {
                Button(action: onPrevious) {
                    Image(systemName: "backward.fill")
                        .font(.title2)
                }
                
                Button(action: { isPlaying.toggle() }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .frame(width: 60, height: 60)
                        .background(Circle().fill(.regularMaterial))
                }
                
                Button(action: onNext) {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                }
            }
            .buttonStyle(.plain)
            
            // Volume
            HStack {
                Image(systemName: "speaker.fill")
                    .font(.caption)
                
                Slider(value: $volume, in: 0...1)
                    .frame(width: 120)
                
                Image(systemName: "speaker.wave.3.fill")
                    .font(.caption)
            }
            .foregroundStyle(.secondary)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
    }
}

@available(visionOS 2.0, *)
private struct ProgressBar: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.secondary.opacity(0.3))
                
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: geometry.size.width * value)
            }
        }
        .frame(height: 4)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    value = min(max(0, gesture.location.x / 200), 1)
                }
        )
    }
}

// MARK: - Breadcrumb Ornament

/// A breadcrumb navigation ornament.
@available(visionOS 2.0, *)
public struct BreadcrumbOrnament: View {
    
    private let items: [BreadcrumbItem]
    private let onSelect: (Int) -> Void
    
    public init(items: [BreadcrumbItem], onSelect: @escaping (Int) -> Void) {
        self.items = items
        self.onSelect = onSelect
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                if index > 0 {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Button(action: { onSelect(index) }) {
                    HStack(spacing: 4) {
                        if let icon = item.icon {
                            Image(systemName: icon)
                                .font(.caption)
                        }
                        Text(item.title)
                            .font(.subheadline)
                    }
                    .foregroundStyle(index == items.count - 1 ? .primary : .secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
        )
    }
}

/// A breadcrumb navigation item.
public struct BreadcrumbItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let icon: String?
    
    public init(title: String, icon: String? = nil) {
        self.title = title
        self.icon = icon
    }
}
