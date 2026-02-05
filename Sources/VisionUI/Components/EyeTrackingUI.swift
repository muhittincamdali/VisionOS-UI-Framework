// EyeTrackingUI.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit
import ARKit

// MARK: - Eye Tracking UI System
/// A comprehensive eye tracking UI system for visionOS.
/// Enables gaze-based interactions, dwell selection, and attention-aware UI.
///
/// Example:
/// ```swift
/// EyeTrackingView {
///     GazeButton("Select Me") {
///         performAction()
///     }
///     .dwellDuration(0.5)
/// }
/// .gazeIndicator(.spotlight)
/// ```
@available(visionOS 2.0, *)
public struct EyeTrackingView<Content: View>: View {
    
    // MARK: - Properties
    
    private let content: Content
    private var gazeIndicatorStyle: GazeIndicatorStyle = .subtle
    private var dwellEnabled: Bool = true
    private var defaultDwellDuration: Double = 0.8
    private var showDebugInfo: Bool = false
    
    @State private var gazePoint: CGPoint = .zero
    @State private var isGazing: Bool = false
    @State private var gazeTarget: String?
    
    // MARK: - Initialization
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            content
            
            if showDebugInfo {
                debugOverlay
            }
            
            gazeIndicator
        }
        .task {
            await startEyeTracking()
        }
    }
    
    private var debugOverlay: some View {
        VStack(alignment: .leading) {
            Text("Gaze: (\(Int(gazePoint.x)), \(Int(gazePoint.y)))")
            Text("Target: \(gazeTarget ?? "None")")
            Text("Gazing: \(isGazing ? "Yes" : "No")")
        }
        .font(.caption)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    @ViewBuilder
    private var gazeIndicator: some View {
        switch gazeIndicatorStyle {
        case .none:
            EmptyView()
        case .subtle:
            Circle()
                .stroke(Color.accentColor.opacity(0.5), lineWidth: 2)
                .frame(width: 20, height: 20)
                .position(gazePoint)
                .opacity(isGazing ? 1 : 0)
        case .spotlight:
            Circle()
                .fill(
                    RadialGradient(
                        colors: [.white.opacity(0.3), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 40
                    )
                )
                .frame(width: 80, height: 80)
                .position(gazePoint)
                .opacity(isGazing ? 1 : 0)
                .blendMode(.plusLighter)
        case .reticle:
            ReticleView()
                .frame(width: 40, height: 40)
                .position(gazePoint)
                .opacity(isGazing ? 1 : 0)
        case .custom(let view):
            AnyView(view)
                .position(gazePoint)
                .opacity(isGazing ? 1 : 0)
        }
    }
    
    // MARK: - Eye Tracking
    
    private func startEyeTracking() async {
        #if os(visionOS)
        // Eye tracking session setup
        #endif
    }
    
    // MARK: - Modifiers
    
    /// Sets the gaze indicator style.
    public func gazeIndicator(_ style: GazeIndicatorStyle) -> EyeTrackingView {
        var copy = self
        copy.gazeIndicatorStyle = style
        return copy
    }
    
    /// Enables or disables dwell selection.
    public func dwellSelection(_ enabled: Bool) -> EyeTrackingView {
        var copy = self
        copy.dwellEnabled = enabled
        return copy
    }
    
    /// Sets the default dwell duration.
    public func dwellDuration(_ duration: Double) -> EyeTrackingView {
        var copy = self
        copy.defaultDwellDuration = duration
        return copy
    }
    
    /// Shows debug information overlay.
    public func showDebug(_ show: Bool) -> EyeTrackingView {
        var copy = self
        copy.showDebugInfo = show
        return copy
    }
}

// MARK: - Gaze Indicator Styles

/// Visual styles for the gaze indicator.
public enum GazeIndicatorStyle {
    case none
    case subtle
    case spotlight
    case reticle
    case custom(AnyView)
}

// MARK: - Reticle View

private struct ReticleView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
            
            ForEach(0..<4) { index in
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 2, height: 8)
                    .offset(y: -16)
                    .rotationEffect(.degrees(Double(index) * 90 + rotation))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

// MARK: - Gaze Button

/// A button that activates when gazed at for a specified duration.
@available(visionOS 2.0, *)
public struct GazeButton: View {
    
    private let title: String
    private let icon: String?
    private let action: () -> Void
    private var dwellDuration: Double = 0.8
    private var showProgress: Bool = true
    private var hapticFeedback: Bool = true
    
    @State private var isGazed: Bool = false
    @State private var dwellProgress: Double = 0
    @State private var isActivated: Bool = false
    @State private var dwellTimer: Timer?
    
    public init(
        _ title: String,
        icon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                // Background with progress
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                
                if showProgress && isGazed {
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.accentColor.opacity(0.3))
                            .frame(width: geometry.size.width * dwellProgress)
                    }
                }
                
                // Content
                HStack(spacing: 8) {
                    if let icon = icon {
                        Image(systemName: icon)
                    }
                    Text(title)
                }
                .fontWeight(.medium)
            }
            .frame(minWidth: 100, minHeight: 44)
        }
        .buttonStyle(.plain)
        .scaleEffect(isGazed ? 1.05 : 1.0)
        .scaleEffect(isActivated ? 0.95 : 1.0)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.accentColor, lineWidth: isGazed ? 2 : 0)
        }
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isGazed = hovering
            }
            
            if hovering {
                startDwellTimer()
            } else {
                cancelDwellTimer()
            }
        }
        .animation(.spring(response: 0.2), value: isGazed)
        .animation(.spring(response: 0.1), value: isActivated)
    }
    
    private func startDwellTimer() {
        dwellProgress = 0
        let interval = 0.016 // ~60fps
        let increment = interval / dwellDuration
        
        dwellTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            dwellProgress += increment
            
            if dwellProgress >= 1.0 {
                activateButton()
                timer.invalidate()
            }
        }
    }
    
    private func cancelDwellTimer() {
        dwellTimer?.invalidate()
        dwellTimer = nil
        withAnimation(.easeOut(duration: 0.2)) {
            dwellProgress = 0
        }
    }
    
    private func activateButton() {
        isActivated = true
        
        if hapticFeedback {
            triggerHaptic()
        }
        
        action()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isActivated = false
            dwellProgress = 0
        }
    }
    
    private func triggerHaptic() {
        #if os(visionOS)
        // Haptic feedback
        #endif
    }
    
    /// Sets the dwell duration for activation.
    public func dwellDuration(_ duration: Double) -> GazeButton {
        var copy = self
        copy.dwellDuration = duration
        return copy
    }
    
    /// Shows or hides the progress indicator.
    public func showProgress(_ show: Bool) -> GazeButton {
        var copy = self
        copy.showProgress = show
        return copy
    }
    
    /// Enables or disables haptic feedback.
    public func hapticFeedback(_ enabled: Bool) -> GazeButton {
        var copy = self
        copy.hapticFeedback = enabled
        return copy
    }
}

// MARK: - Attention Aware View

/// A view that responds to user attention/gaze.
@available(visionOS 2.0, *)
public struct AttentionAwareView<Content: View, AttentionContent: View>: View {
    
    private let normalContent: Content
    private let attentionContent: AttentionContent
    private var transitionDuration: Double = 0.3
    private var attentionDelay: Double = 0.5
    
    @State private var isAttended: Bool = false
    @State private var attentionTimer: Timer?
    
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder whenAttended: () -> AttentionContent
    ) {
        self.normalContent = content()
        self.attentionContent = whenAttended()
    }
    
    public var body: some View {
        Group {
            if isAttended {
                attentionContent
                    .transition(.opacity.combined(with: .scale))
            } else {
                normalContent
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.easeInOut(duration: transitionDuration), value: isAttended)
        .onHover { hovering in
            if hovering {
                attentionTimer = Timer.scheduledTimer(withTimeInterval: attentionDelay, repeats: false) { _ in
                    withAnimation {
                        isAttended = true
                    }
                }
            } else {
                attentionTimer?.invalidate()
                withAnimation {
                    isAttended = false
                }
            }
        }
    }
    
    /// Sets the transition duration.
    public func transitionDuration(_ duration: Double) -> AttentionAwareView {
        var copy = self
        copy.transitionDuration = duration
        return copy
    }
    
    /// Sets the delay before showing attention content.
    public func attentionDelay(_ delay: Double) -> AttentionAwareView {
        var copy = self
        copy.attentionDelay = delay
        return copy
    }
}

// MARK: - Gaze Scroll View

/// A scroll view that scrolls based on gaze position.
@available(visionOS 2.0, *)
public struct GazeScrollView<Content: View>: View {
    
    private let content: Content
    private var scrollSpeed: CGFloat = 100
    private var edgeThreshold: CGFloat = 0.2
    
    @State private var scrollOffset: CGFloat = 0
    @State private var gazePosition: CGFloat = 0.5
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                content
                    .offset(y: scrollOffset)
            }
            .onContinuousHover { phase in
                switch phase {
                case .active(let location):
                    let normalizedY = location.y / geometry.size.height
                    gazePosition = normalizedY
                    updateScroll()
                case .ended:
                    break
                }
            }
        }
    }
    
    private func updateScroll() {
        if gazePosition < edgeThreshold {
            // Scroll up
            let intensity = (edgeThreshold - gazePosition) / edgeThreshold
            scrollOffset += scrollSpeed * intensity * 0.016
        } else if gazePosition > (1 - edgeThreshold) {
            // Scroll down
            let intensity = (gazePosition - (1 - edgeThreshold)) / edgeThreshold
            scrollOffset -= scrollSpeed * intensity * 0.016
        }
    }
    
    /// Sets the scroll speed.
    public func scrollSpeed(_ speed: CGFloat) -> GazeScrollView {
        var copy = self
        copy.scrollSpeed = speed
        return copy
    }
    
    /// Sets the edge threshold for triggering scroll.
    public func edgeThreshold(_ threshold: CGFloat) -> GazeScrollView {
        var copy = self
        copy.edgeThreshold = threshold
        return copy
    }
}

// MARK: - Gaze Heat Map

/// A debug view that visualizes gaze patterns as a heat map.
@available(visionOS 2.0, *)
public struct GazeHeatMap: View {
    
    @State private var gazePoints: [GazePoint] = []
    private var resolution: Int = 20
    private var decayRate: Double = 0.95
    
    public init() {}
    
    public var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                let cellWidth = size.width / CGFloat(resolution)
                let cellHeight = size.height / CGFloat(resolution)
                
                var heatGrid = Array(repeating: Array(repeating: 0.0, count: resolution), count: resolution)
                
                for point in gazePoints {
                    let gridX = Int(point.position.x / cellWidth)
                    let gridY = Int(point.position.y / cellHeight)
                    
                    if gridX >= 0 && gridX < resolution && gridY >= 0 && gridY < resolution {
                        heatGrid[gridY][gridX] += point.intensity
                    }
                }
                
                for y in 0..<resolution {
                    for x in 0..<resolution {
                        let intensity = min(heatGrid[y][x], 1.0)
                        let color = Color(
                            red: intensity,
                            green: 1 - intensity,
                            blue: 0
                        ).opacity(intensity * 0.5)
                        
                        let rect = CGRect(
                            x: CGFloat(x) * cellWidth,
                            y: CGFloat(y) * cellHeight,
                            width: cellWidth,
                            height: cellHeight
                        )
                        
                        context.fill(Path(ellipseIn: rect), with: .color(color))
                    }
                }
            }
        }
        .allowsHitTesting(false)
    }
    
    private struct GazePoint {
        let position: CGPoint
        var intensity: Double
        let timestamp: Date
    }
}

// MARK: - Focus Ring

/// A visual focus ring that follows the user's gaze.
@available(visionOS 2.0, *)
public struct FocusRing: View {
    
    @Binding private var focusPoint: CGPoint
    private var size: CGFloat = 60
    private var color: Color = .accentColor
    private var animated: Bool = true
    
    @State private var pulseScale: CGFloat = 1.0
    
    public init(focusPoint: Binding<CGPoint>) {
        self._focusPoint = focusPoint
    }
    
    public var body: some View {
        ZStack {
            // Outer pulse ring
            Circle()
                .stroke(color.opacity(0.3), lineWidth: 2)
                .frame(width: size * pulseScale, height: size * pulseScale)
            
            // Inner ring
            Circle()
                .stroke(color, lineWidth: 3)
                .frame(width: size * 0.6, height: size * 0.6)
            
            // Center dot
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
        }
        .position(focusPoint)
        .onAppear {
            if animated {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    pulseScale = 1.2
                }
            }
        }
    }
    
    /// Sets the ring size.
    public func size(_ value: CGFloat) -> FocusRing {
        var copy = self
        copy.size = value
        return copy
    }
    
    /// Sets the ring color.
    public func color(_ value: Color) -> FocusRing {
        var copy = self
        copy.color = value
        return copy
    }
    
    /// Enables or disables the pulse animation.
    public func animated(_ value: Bool) -> FocusRing {
        var copy = self
        copy.animated = value
        return copy
    }
}
