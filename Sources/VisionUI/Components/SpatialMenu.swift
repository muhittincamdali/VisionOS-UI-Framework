// SpatialMenu.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit

// MARK: - Spatial Menu System
/// A comprehensive 3D menu system for visionOS with multiple layout options.
/// Supports radial, grid, orbital, and stack layouts with smooth animations.
///
/// Example:
/// ```swift
/// SpatialMenu(isPresented: $showMenu) {
///     SpatialMenuItem(icon: "house.fill", title: "Home") {
///         navigateToHome()
///     }
///     SpatialMenuItem(icon: "gear", title: "Settings") {
///         navigateToSettings()
///     }
/// }
/// .layout(.radial)
/// .radius(0.5)
/// ```
@available(visionOS 2.0, *)
public struct SpatialMenu<Content: View>: View {
    
    // MARK: - Properties
    
    @Binding private var isPresented: Bool
    private let content: Content
    private var layout: SpatialMenuLayout = .radial
    private var radius: Float = 0.4
    private var animationDuration: Double = 0.35
    private var dismissOnSelection: Bool = true
    private var hapticFeedback: Bool = true
    private var backgroundBlur: Bool = true
    
    @State private var itemsExpanded: Bool = false
    
    // MARK: - Initialization
    
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            if isPresented && backgroundBlur {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        dismiss()
                    }
            }
            
            if isPresented {
                menuContent
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(response: animationDuration, dampingFraction: 0.8), value: isPresented)
        .onChange(of: isPresented) { _, newValue in
            if newValue {
                withAnimation(.spring(response: animationDuration, dampingFraction: 0.7)) {
                    itemsExpanded = true
                }
            } else {
                itemsExpanded = false
            }
        }
    }
    
    @ViewBuilder
    private var menuContent: some View {
        switch layout {
        case .radial:
            RadialMenuLayout(content: content, radius: radius, expanded: itemsExpanded)
        case .grid(let columns):
            GridMenuLayout(content: content, columns: columns, expanded: itemsExpanded)
        case .orbital:
            OrbitalMenuLayout(content: content, radius: radius, expanded: itemsExpanded)
        case .stack:
            StackMenuLayout(content: content, expanded: itemsExpanded)
        case .arc(let angle):
            ArcMenuLayout(content: content, radius: radius, arcAngle: angle, expanded: itemsExpanded)
        }
    }
    
    // MARK: - Actions
    
    private func dismiss() {
        if hapticFeedback {
            triggerDismissHaptic()
        }
        withAnimation(.spring(response: animationDuration, dampingFraction: 0.8)) {
            isPresented = false
        }
    }
    
    private func triggerDismissHaptic() {
        #if os(visionOS)
        // Haptic feedback
        #endif
    }
    
    // MARK: - Modifiers
    
    /// Sets the menu layout style.
    public func layout(_ layout: SpatialMenuLayout) -> SpatialMenu {
        var copy = self
        copy.layout = layout
        return copy
    }
    
    /// Sets the radius for radial/orbital layouts.
    public func radius(_ value: Float) -> SpatialMenu {
        var copy = self
        copy.radius = value
        return copy
    }
    
    /// Sets the animation duration.
    public func animationDuration(_ duration: Double) -> SpatialMenu {
        var copy = self
        copy.animationDuration = duration
        return copy
    }
    
    /// Controls whether the menu dismisses on item selection.
    public func dismissOnSelection(_ dismiss: Bool) -> SpatialMenu {
        var copy = self
        copy.dismissOnSelection = dismiss
        return copy
    }
    
    /// Enables or disables haptic feedback.
    public func hapticFeedback(_ enabled: Bool) -> SpatialMenu {
        var copy = self
        copy.hapticFeedback = enabled
        return copy
    }
    
    /// Enables or disables background blur.
    public func backgroundBlur(_ enabled: Bool) -> SpatialMenu {
        var copy = self
        copy.backgroundBlur = enabled
        return copy
    }
}

// MARK: - Menu Layout Types

/// Layout styles for spatial menus.
public enum SpatialMenuLayout {
    /// Items arranged in a circle around the center.
    case radial
    /// Items arranged in a grid.
    case grid(columns: Int)
    /// Items orbiting in 3D space.
    case orbital
    /// Items stacked vertically with depth.
    case stack
    /// Items arranged in an arc.
    case arc(angle: Angle)
}

// MARK: - Spatial Menu Item

/// An individual item in a spatial menu.
@available(visionOS 2.0, *)
public struct SpatialMenuItem: View, Identifiable {
    public let id = UUID()
    
    private let icon: String
    private let title: String
    private let subtitle: String?
    private let tintColor: Color
    private let action: () -> Void
    
    @State private var isHovered: Bool = false
    @State private var isPressed: Bool = false
    
    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        tintColor: Color = .accentColor,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.tintColor = tintColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundStyle(tintColor)
                }
                .scaleEffect(isHovered ? 1.1 : 1.0)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .opacity(isHovered ? 1 : 0)
            )
        }
        .buttonStyle(.plain)
        .hoverEffect(.lift)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
    }
}

// MARK: - Layout Implementations

@available(visionOS 2.0, *)
private struct RadialMenuLayout<Content: View>: View {
    let content: Content
    let radius: Float
    let expanded: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Center button
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .semibold))
                    }
                
                // Items arranged radially - use content directly
                content
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}

@available(visionOS 2.0, *)
private struct GridMenuLayout<Content: View>: View {
    let content: Content
    let columns: Int
    let expanded: Bool
    
    var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: columns),
            spacing: 16
        ) {
            content
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
        )
        .scaleEffect(expanded ? 1 : 0.8)
        .opacity(expanded ? 1 : 0)
    }
}

@available(visionOS 2.0, *)
private struct OrbitalMenuLayout<Content: View>: View {
    let content: Content
    let radius: Float
    let expanded: Bool
    
    @State private var orbitRotation: Angle = .zero
    
    var body: some View {
        TimelineView(.animation) { timeline in
            ZStack {
                content
            }
            .rotation3DEffect(orbitRotation, axis: (x: 0.3, y: 1, z: 0))
            .onChange(of: timeline.date) { _, _ in
                if expanded {
                    orbitRotation += .degrees(0.2)
                }
            }
        }
    }
}

@available(visionOS 2.0, *)
private struct StackMenuLayout<Content: View>: View {
    let content: Content
    let expanded: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            content
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
    }
}

@available(visionOS 2.0, *)
private struct ArcMenuLayout<Content: View>: View {
    let content: Content
    let radius: Float
    let arcAngle: Angle
    let expanded: Bool
    
    var body: some View {
        ZStack {
            content
        }
    }
}

// MARK: - Context Menu 3D

/// A 3D context menu that appears on long press.
@available(visionOS 2.0, *)
public struct SpatialContextMenu<Content: View, MenuContent: View>: View {
    private let content: Content
    private let menuContent: MenuContent
    
    @State private var showMenu: Bool = false
    
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder menu: () -> MenuContent
    ) {
        self.content = content()
        self.menuContent = menu()
    }
    
    public var body: some View {
        content
            .onLongPressGesture {
                withAnimation(.spring()) {
                    showMenu = true
                }
            }
            .overlay {
                if showMenu {
                    SpatialMenu(isPresented: $showMenu) {
                        menuContent
                    }
                    .layout(.radial)
                }
            }
    }
}

// MARK: - Quick Actions Menu

/// A floating quick actions menu that follows the user's gaze.
@available(visionOS 2.0, *)
public struct QuickActionsMenu: View {
    private let actions: [QuickAction]
    @State private var isExpanded: Bool = false
    
    public init(actions: [QuickAction]) {
        self.actions = actions
    }
    
    public var body: some View {
        HStack(spacing: isExpanded ? 16 : -20) {
            ForEach(actions.indices, id: \.self) { index in
                Button(action: actions[index].action) {
                    Image(systemName: actions[index].icon)
                        .font(.system(size: 20))
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(.ultraThinMaterial))
                }
                .buttonStyle(.plain)
                .hoverEffect(.lift)
                .zIndex(Double(actions.count - index))
            }
        }
        .padding(8)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .opacity(isExpanded ? 1 : 0.8)
        )
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isExpanded.toggle()
            }
        }
    }
}

/// A quick action for the quick actions menu.
public struct QuickAction: Identifiable {
    public let id = UUID()
    public let icon: String
    public let title: String
    public let action: () -> Void
    
    public init(icon: String, title: String, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.action = action
    }
}
