// WindowManagement.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI

// MARK: - Window Management System
/// A comprehensive window management system for visionOS.
/// Enables multi-window layouts, snap zones, and window orchestration.
///
/// Example:
/// ```swift
/// WindowManager {
///     ManagedWindow("Main") {
///         MainContentView()
///     }
///     .defaultSize(width: 800, height: 600)
///     .snapBehavior(.edges)
/// }
/// ```
@available(visionOS 2.0, *)
public struct WindowManager<Content: View>: View {
    
    private let content: Content
    private var enableSnapping: Bool = true
    private var enableCascade: Bool = true
    private var showMinimizedDock: Bool = true
    
    @State private var windows: [WindowState] = []
    @State private var focusedWindowId: UUID?
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            content
            
            if showMinimizedDock && !minimizedWindows.isEmpty {
                MinimizedDock(windows: minimizedWindows) { windowId in
                    restoreWindow(windowId)
                }
            }
        }
    }
    
    private var minimizedWindows: [WindowState] {
        windows.filter { $0.isMinimized }
    }
    
    private func restoreWindow(_ id: UUID) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            windows[index].isMinimized = false
        }
    }
    
    /// Enables or disables window snapping.
    public func snapping(_ enabled: Bool) -> WindowManager {
        var copy = self
        copy.enableSnapping = enabled
        return copy
    }
    
    /// Enables or disables cascade window arrangement.
    public func cascade(_ enabled: Bool) -> WindowManager {
        var copy = self
        copy.enableCascade = enabled
        return copy
    }
    
    /// Shows or hides the minimized window dock.
    public func minimizedDock(_ show: Bool) -> WindowManager {
        var copy = self
        copy.showMinimizedDock = show
        return copy
    }
}

// MARK: - Window State

/// The state of a managed window.
public struct WindowState: Identifiable {
    public let id: UUID
    public var title: String
    public var position: CGPoint
    public var size: CGSize
    public var isMinimized: Bool
    public var isMaximized: Bool
    public var zIndex: Int
    
    public init(
        title: String,
        position: CGPoint = .zero,
        size: CGSize = CGSize(width: 800, height: 600)
    ) {
        self.id = UUID()
        self.title = title
        self.position = position
        self.size = size
        self.isMinimized = false
        self.isMaximized = false
        self.zIndex = 0
    }
}

// MARK: - Managed Window

/// A window managed by the WindowManager.
@available(visionOS 2.0, *)
public struct ManagedWindow<Content: View>: View {
    
    private let title: String
    private let content: Content
    private var defaultWidth: CGFloat = 800
    private var defaultHeight: CGFloat = 600
    private var minWidth: CGFloat = 300
    private var minHeight: CGFloat = 200
    private var maxWidth: CGFloat? = nil
    private var maxHeight: CGFloat? = nil
    private var snapBehavior: SnapBehavior = .none
    private var resizable: Bool = true
    private var closable: Bool = true
    private var minimizable: Bool = true
    
    @State private var position: CGPoint = .zero
    @State private var size: CGSize = CGSize(width: 800, height: 600)
    @State private var isDragging: Bool = false
    @State private var isResizing: Bool = false
    @State private var dragOffset: CGSize = .zero
    
    public init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Title bar
            WindowTitleBar(
                title: title,
                isDragging: $isDragging,
                onClose: closable ? closeWindow : nil,
                onMinimize: minimizable ? minimizeWindow : nil,
                onMaximize: toggleMaximize
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        position = CGPoint(
                            x: position.x + value.translation.width,
                            y: position.y + value.translation.height
                        )
                    }
                    .onEnded { _ in
                        isDragging = false
                        snapToNearestEdge()
                    }
            )
            
            // Content
            content
                .frame(width: size.width, height: size.height)
            
            // Resize handle
            if resizable {
                ResizeHandle(isResizing: $isResizing) { delta in
                    let newWidth = max(minWidth, min(maxWidth ?? .infinity, size.width + delta.width))
                    let newHeight = max(minHeight, min(maxHeight ?? .infinity, size.height + delta.height))
                    size = CGSize(width: newWidth, height: newHeight)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .shadow(radius: isDragging ? 20 : 10)
        )
        .position(position)
        .onAppear {
            size = CGSize(width: defaultWidth, height: defaultHeight)
        }
    }
    
    private func closeWindow() {
        // Close window logic
    }
    
    private func minimizeWindow() {
        // Minimize window logic
    }
    
    private func toggleMaximize() {
        // Toggle maximize logic
    }
    
    private func snapToNearestEdge() {
        guard snapBehavior != .none else { return }
        // Snap logic based on behavior
    }
    
    // MARK: - Modifiers
    
    /// Sets the default window size.
    public func defaultSize(width: CGFloat, height: CGFloat) -> ManagedWindow {
        var copy = self
        copy.defaultWidth = width
        copy.defaultHeight = height
        return copy
    }
    
    /// Sets the minimum window size.
    public func minSize(width: CGFloat, height: CGFloat) -> ManagedWindow {
        var copy = self
        copy.minWidth = width
        copy.minHeight = height
        return copy
    }
    
    /// Sets the maximum window size.
    public func maxSize(width: CGFloat, height: CGFloat) -> ManagedWindow {
        var copy = self
        copy.maxWidth = width
        copy.maxHeight = height
        return copy
    }
    
    /// Sets the snap behavior.
    public func snapBehavior(_ behavior: SnapBehavior) -> ManagedWindow {
        var copy = self
        copy.snapBehavior = behavior
        return copy
    }
    
    /// Enables or disables resizing.
    public func resizable(_ enabled: Bool) -> ManagedWindow {
        var copy = self
        copy.resizable = enabled
        return copy
    }
    
    /// Enables or disables closing.
    public func closable(_ enabled: Bool) -> ManagedWindow {
        var copy = self
        copy.closable = enabled
        return copy
    }
    
    /// Enables or disables minimizing.
    public func minimizable(_ enabled: Bool) -> ManagedWindow {
        var copy = self
        copy.minimizable = enabled
        return copy
    }
}

// MARK: - Snap Behavior

/// Window snap behaviors.
public enum SnapBehavior {
    case none
    case edges
    case grid(columns: Int, rows: Int)
    case zones([SnapZone])
}

/// A snap zone for window positioning.
public struct SnapZone: Identifiable {
    public let id = UUID()
    public let frame: CGRect
    public let label: String?
    
    public init(frame: CGRect, label: String? = nil) {
        self.frame = frame
        self.label = label
    }
}

// MARK: - Window Title Bar

@available(visionOS 2.0, *)
private struct WindowTitleBar: View {
    let title: String
    @Binding var isDragging: Bool
    let onClose: (() -> Void)?
    let onMinimize: (() -> Void)?
    let onMaximize: () -> Void
    
    var body: some View {
        HStack {
            // Window controls
            HStack(spacing: 8) {
                if let onClose = onClose {
                    WindowControlButton(color: .red, action: onClose)
                }
                if let onMinimize = onMinimize {
                    WindowControlButton(color: .yellow, action: onMinimize)
                }
                WindowControlButton(color: .green, action: onMaximize)
            }
            .padding(.leading, 12)
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            // Placeholder for symmetry
            HStack(spacing: 8) {
                Color.clear.frame(width: 12, height: 12)
                Color.clear.frame(width: 12, height: 12)
                Color.clear.frame(width: 12, height: 12)
            }
            .padding(.trailing, 12)
        }
        .frame(height: 44)
        .background(
            isDragging ? Color.accentColor.opacity(0.1) : Color.clear
        )
    }
}

@available(visionOS 2.0, *)
private struct WindowControlButton: View {
    let color: Color
    let action: () -> Void
    
    @State private var isHovered: Bool = false
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
                .overlay {
                    if isHovered {
                        // Show icon on hover
                    }
                }
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

// MARK: - Resize Handle

@available(visionOS 2.0, *)
private struct ResizeHandle: View {
    @Binding var isResizing: Bool
    let onResize: (CGSize) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: "arrow.down.right")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 16, height: 16)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isResizing = true
                            onResize(value.translation)
                        }
                        .onEnded { _ in
                            isResizing = false
                        }
                )
        }
        .padding(4)
    }
}

// MARK: - Minimized Dock

@available(visionOS 2.0, *)
private struct MinimizedDock: View {
    let windows: [WindowState]
    let onRestore: (UUID) -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(windows) { window in
                Button(action: { onRestore(window.id) }) {
                    VStack {
                        Image(systemName: "macwindow")
                        Text(window.title)
                            .font(.caption2)
                            .lineLimit(1)
                    }
                    .frame(width: 60, height: 50)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(8)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding()
    }
}

// MARK: - Split View

/// A split view container for visionOS.
@available(visionOS 2.0, *)
public struct SpatialSplitView<Primary: View, Secondary: View>: View {
    
    private let primary: Primary
    private let secondary: Secondary
    private var splitRatio: CGFloat = 0.5
    private var orientation: SplitOrientation = .horizontal
    private var showDivider: Bool = true
    private var minPrimarySize: CGFloat = 200
    private var minSecondarySize: CGFloat = 200
    
    @State private var currentRatio: CGFloat = 0.5
    @State private var isDraggingDivider: Bool = false
    
    public init(
        @ViewBuilder primary: () -> Primary,
        @ViewBuilder secondary: () -> Secondary
    ) {
        self.primary = primary()
        self.secondary = secondary()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Group {
                switch orientation {
                case .horizontal:
                    HStack(spacing: 0) {
                        primary
                            .frame(width: geometry.size.width * currentRatio)
                        
                        if showDivider {
                            SplitDivider(orientation: .vertical, isDragging: $isDraggingDivider) { delta in
                                let newRatio = currentRatio + delta / geometry.size.width
                                currentRatio = max(0.1, min(0.9, newRatio))
                            }
                        }
                        
                        secondary
                    }
                    
                case .vertical:
                    VStack(spacing: 0) {
                        primary
                            .frame(height: geometry.size.height * currentRatio)
                        
                        if showDivider {
                            SplitDivider(orientation: .horizontal, isDragging: $isDraggingDivider) { delta in
                                let newRatio = currentRatio + delta / geometry.size.height
                                currentRatio = max(0.1, min(0.9, newRatio))
                            }
                        }
                        
                        secondary
                    }
                }
            }
        }
        .onAppear {
            currentRatio = splitRatio
        }
    }
    
    /// Sets the initial split ratio.
    public func splitRatio(_ ratio: CGFloat) -> SpatialSplitView {
        var copy = self
        copy.splitRatio = ratio
        return copy
    }
    
    /// Sets the split orientation.
    public func orientation(_ orientation: SplitOrientation) -> SpatialSplitView {
        var copy = self
        copy.orientation = orientation
        return copy
    }
    
    /// Shows or hides the divider.
    public func showDivider(_ show: Bool) -> SpatialSplitView {
        var copy = self
        copy.showDivider = show
        return copy
    }
}

/// Split view orientations.
public enum SplitOrientation {
    case horizontal
    case vertical
}

@available(visionOS 2.0, *)
private struct SplitDivider: View {
    let orientation: Axis
    @Binding var isDragging: Bool
    let onDrag: (CGFloat) -> Void
    
    var body: some View {
        Rectangle()
            .fill(isDragging ? Color.accentColor : Color.gray.opacity(0.5))
            .frame(
                width: orientation == .vertical ? 4 : nil,
                height: orientation == .horizontal ? 4 : nil
            )
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        switch orientation {
                        case .horizontal:
                            onDrag(value.translation.height)
                        case .vertical:
                            onDrag(value.translation.width)
                        }
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            .onHover { hovering in
                // Change cursor
            }
    }
}

// MARK: - Picture in Picture

/// A picture-in-picture window for visionOS.
@available(visionOS 2.0, *)
public struct PictureInPicture<Content: View>: View {
    
    private let content: Content
    @Binding private var isActive: Bool
    private var size: CGSize = CGSize(width: 320, height: 180)
    private var corner: RectCorner = .bottomTrailing
    
    @State private var position: CGPoint = .zero
    @State private var isDragging: Bool = false
    
    public init(
        isActive: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self._isActive = isActive
        self.content = content()
    }
    
    public var body: some View {
        if isActive {
            content
                .frame(width: size.width, height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(radius: 10)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            position = value.location
                        }
                        .onEnded { _ in
                            isDragging = false
                        }
                )
                .position(position)
                .transition(.scale.combined(with: .opacity))
        }
    }
    
    /// Sets the PiP window size.
    public func size(width: CGFloat, height: CGFloat) -> PictureInPicture {
        var copy = self
        copy.size = CGSize(width: width, height: height)
        return copy
    }
    
    /// Sets the default corner position.
    public func corner(_ corner: RectCorner) -> PictureInPicture {
        var copy = self
        copy.corner = corner
        return copy
    }
}

/// Corner positions for PiP windows.
public enum RectCorner {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}
