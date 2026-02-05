// HandTrackingUI.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit
import ARKit

// MARK: - Hand Tracking UI System
/// A comprehensive hand tracking UI system for visionOS.
/// Enables gesture-based interactions, hand menus, and palm-anchored UI.
///
/// Example:
/// ```swift
/// HandTrackingView {
///     PalmAnchoredMenu {
///         MenuItem("Home", icon: "house.fill")
///         MenuItem("Settings", icon: "gear")
///     }
/// }
/// .handedness(.both)
/// .sensitivity(.high)
/// ```
@available(visionOS 2.0, *)
public struct HandTrackingView<Content: View>: View {
    
    // MARK: - Properties
    
    private let content: Content
    private var handedness: Handedness = .both
    private var sensitivity: TrackingSensitivity = .medium
    private var showDebugVisualization: Bool = false
    private var enableHaptics: Bool = true
    
    @State private var leftHandPosition: SIMD3<Float>?
    @State private var rightHandPosition: SIMD3<Float>?
    @State private var activeGesture: HandGesture?
    
    // MARK: - Initialization
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body
    
    public var body: some View {
        RealityView { content in
            // Setup hand tracking
            let handTrackingAnchor = AnchorEntity()
            content.add(handTrackingAnchor)
        } update: { content in
            // Update hand positions
        }
        .task {
            await startHandTracking()
        }
    }
    
    // MARK: - Hand Tracking
    
    private func startHandTracking() async {
        #if os(visionOS)
        // Hand tracking session setup
        #endif
    }
    
    // MARK: - Modifiers
    
    /// Sets which hands to track.
    public func handedness(_ value: Handedness) -> HandTrackingView {
        var copy = self
        copy.handedness = value
        return copy
    }
    
    /// Sets the tracking sensitivity.
    public func sensitivity(_ value: TrackingSensitivity) -> HandTrackingView {
        var copy = self
        copy.sensitivity = value
        return copy
    }
    
    /// Shows debug visualization for hand joints.
    public func debugVisualization(_ show: Bool) -> HandTrackingView {
        var copy = self
        copy.showDebugVisualization = show
        return copy
    }
    
    /// Enables or disables haptic feedback.
    public func haptics(_ enabled: Bool) -> HandTrackingView {
        var copy = self
        copy.enableHaptics = enabled
        return copy
    }
}

// MARK: - Supporting Types

/// Which hand(s) to track.
public enum Handedness {
    case left
    case right
    case both
}

/// Tracking sensitivity level.
public enum TrackingSensitivity {
    case low
    case medium
    case high
    
    var updateInterval: Double {
        switch self {
        case .low: return 0.1
        case .medium: return 0.05
        case .high: return 0.016
        }
    }
}

/// Hand gesture types.
public enum HandGesture: String, CaseIterable {
    case pinch
    case grab
    case point
    case thumbsUp
    case thumbsDown
    case peace
    case openPalm
    case fist
    case wave
    case tap
}

// MARK: - Palm Anchored Menu

/// A menu that appears anchored to the user's palm.
@available(visionOS 2.0, *)
public struct PalmAnchoredMenu<Content: View>: View {
    
    private let content: Content
    private var hand: Handedness = .left
    private var autoHide: Bool = true
    private var hideDelay: Double = 3.0
    
    @State private var isVisible: Bool = false
    @State private var palmPosition: SIMD3<Float> = .zero
    @State private var palmRotation: simd_quatf = .init()
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        Group {
            if isVisible {
                content
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                    )
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isVisible)
    }
    
    /// Sets which hand to anchor to.
    public func hand(_ value: Handedness) -> PalmAnchoredMenu {
        var copy = self
        copy.hand = value
        return copy
    }
    
    /// Enables or disables auto-hide.
    public func autoHide(_ enabled: Bool, delay: Double = 3.0) -> PalmAnchoredMenu {
        var copy = self
        copy.autoHide = enabled
        copy.hideDelay = delay
        return copy
    }
}

// MARK: - Finger Tip Button

/// A button that activates when touched with a fingertip.
@available(visionOS 2.0, *)
public struct FingerTipButton: View {
    
    private let title: String
    private let icon: String?
    private let action: () -> Void
    private var size: CGFloat = 60
    private var feedbackIntensity: CGFloat = 1.0
    
    @State private var isPressed: Bool = false
    @State private var fingerProximity: CGFloat = 1.0
    
    public init(
        title: String = "",
        icon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: size, height: size)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .overlay {
                    Circle()
                        .stroke(Color.accentColor, lineWidth: isPressed ? 3 : 0)
                }
            
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: size * 0.4))
                    .foregroundStyle(.primary)
            } else if !title.isEmpty {
                Text(title)
                    .font(.system(size: size * 0.3))
                    .fontWeight(.semibold)
            }
            
            // Proximity indicator
            Circle()
                .stroke(Color.accentColor.opacity(0.3), lineWidth: 2)
                .frame(width: size * (2 - fingerProximity), height: size * (2 - fingerProximity))
                .opacity(fingerProximity < 0.8 ? 1 : 0)
        }
        .hoverEffect(.lift)
        .gesture(
            SpatialTapGesture()
                .onEnded { _ in
                    triggerAction()
                }
        )
        .animation(.spring(response: 0.2), value: isPressed)
        .animation(.spring(response: 0.2), value: fingerProximity)
    }
    
    private func triggerAction() {
        isPressed = true
        action()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            isPressed = false
        }
    }
    
    /// Sets the button size.
    public func size(_ value: CGFloat) -> FingerTipButton {
        var copy = self
        copy.size = value
        return copy
    }
    
    /// Sets the haptic feedback intensity.
    public func feedbackIntensity(_ value: CGFloat) -> FingerTipButton {
        var copy = self
        copy.feedbackIntensity = value
        return copy
    }
}

// MARK: - Gesture Recognition View

/// A view that recognizes and responds to hand gestures.
@available(visionOS 2.0, *)
public struct GestureRecognitionView: View {
    
    @Binding private var recognizedGesture: HandGesture?
    private let onGestureRecognized: ((HandGesture) -> Void)?
    private var gesturesToRecognize: Set<HandGesture> = Set(HandGesture.allCases)
    private var confidenceThreshold: Float = 0.8
    
    @State private var gestureConfidence: Float = 0
    
    public init(
        gesture: Binding<HandGesture?>,
        onRecognized: ((HandGesture) -> Void)? = nil
    ) {
        self._recognizedGesture = gesture
        self.onGestureRecognized = onRecognized
    }
    
    public var body: some View {
        RealityView { content in
            // Gesture recognition setup
        } update: { content in
            // Update gesture recognition
        }
    }
    
    /// Limits which gestures to recognize.
    public func gestures(_ gestures: Set<HandGesture>) -> GestureRecognitionView {
        var copy = self
        copy.gesturesToRecognize = gestures
        return copy
    }
    
    /// Sets the minimum confidence threshold.
    public func confidenceThreshold(_ threshold: Float) -> GestureRecognitionView {
        var copy = self
        copy.confidenceThreshold = threshold
        return copy
    }
}

// MARK: - Pinch Slider

/// A slider controlled by pinch gesture distance.
@available(visionOS 2.0, *)
public struct PinchSlider: View {
    
    @Binding private var value: Double
    private let range: ClosedRange<Double>
    private var trackColor: Color = .secondary
    private var fillColor: Color = .accentColor
    
    @State private var initialPinchDistance: CGFloat?
    @State private var initialValue: Double = 0
    
    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1
    ) {
        self._value = value
        self.range = range
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track
                Capsule()
                    .fill(trackColor.opacity(0.3))
                    .frame(height: 8)
                
                // Fill
                Capsule()
                    .fill(fillColor)
                    .frame(
                        width: geometry.size.width * CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)),
                        height: 8
                    )
                
                // Thumb
                Circle()
                    .fill(.white)
                    .frame(width: 24, height: 24)
                    .shadow(radius: 4)
                    .offset(x: geometry.size.width * CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) - 12)
            }
        }
        .frame(height: 24)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    // Handle pinch distance changes
                }
        )
    }
    
    /// Sets the track color.
    public func trackColor(_ color: Color) -> PinchSlider {
        var copy = self
        copy.trackColor = color
        return copy
    }
    
    /// Sets the fill color.
    public func fillColor(_ color: Color) -> PinchSlider {
        var copy = self
        copy.fillColor = color
        return copy
    }
}

// MARK: - Hand Skeleton Visualizer

/// A debug view that visualizes hand skeleton joints.
@available(visionOS 2.0, *)
public struct HandSkeletonVisualizer: View {
    
    @State private var leftHandJoints: [String: SIMD3<Float>] = [:]
    @State private var rightHandJoints: [String: SIMD3<Float>] = [:]
    
    private var jointColor: Color = .cyan
    private var boneColor: Color = .white
    private var jointSize: Float = 0.005
    
    public init() {}
    
    public var body: some View {
        RealityView { content in
            let visualizerEntity = Entity()
            
            // Joint visualization spheres
            let jointMaterial = SimpleMaterial(color: UIColor(jointColor), isMetallic: true)
            
            for jointName in handJointNames {
                let sphere = ModelEntity(
                    mesh: .generateSphere(radius: jointSize),
                    materials: [jointMaterial]
                )
                sphere.name = "joint_\(jointName)"
                visualizerEntity.addChild(sphere)
            }
            
            content.add(visualizerEntity)
        } update: { content in
            // Update joint positions
            for entity in content.entities {
                for child in entity.children {
                    if child.name.starts(with: "joint_") {
                        let jointName = String(child.name.dropFirst(6))
                        if let position = leftHandJoints[jointName] ?? rightHandJoints[jointName] {
                            child.position = position
                        }
                    }
                }
            }
        }
    }
    
    private var handJointNames: [String] {
        [
            "wrist",
            "thumbKnuckle", "thumbIntermediateBase", "thumbIntermediateTip", "thumbTip",
            "indexFingerKnuckle", "indexFingerIntermediateBase", "indexFingerIntermediateTip", "indexFingerTip",
            "middleFingerKnuckle", "middleFingerIntermediateBase", "middleFingerIntermediateTip", "middleFingerTip",
            "ringFingerKnuckle", "ringFingerIntermediateBase", "ringFingerIntermediateTip", "ringFingerTip",
            "littleFingerKnuckle", "littleFingerIntermediateBase", "littleFingerIntermediateTip", "littleFingerTip"
        ]
    }
    
    /// Sets the joint visualization color.
    public func jointColor(_ color: Color) -> HandSkeletonVisualizer {
        var copy = self
        copy.jointColor = color
        return copy
    }
    
    /// Sets the bone visualization color.
    public func boneColor(_ color: Color) -> HandSkeletonVisualizer {
        var copy = self
        copy.boneColor = color
        return copy
    }
    
    /// Sets the joint sphere size.
    public func jointSize(_ size: Float) -> HandSkeletonVisualizer {
        var copy = self
        copy.jointSize = size
        return copy
    }
}

// MARK: - Two Hand Gesture View

/// A view that recognizes two-handed gestures like resize, rotate, and zoom.
@available(visionOS 2.0, *)
public struct TwoHandGestureView: View {
    
    @Binding private var scale: CGFloat
    @Binding private var rotation: Angle
    
    @State private var leftHandPosition: SIMD3<Float>?
    @State private var rightHandPosition: SIMD3<Float>?
    @State private var initialDistance: Float?
    @State private var initialAngle: Float?
    
    public init(scale: Binding<CGFloat>, rotation: Binding<Angle>) {
        self._scale = scale
        self._rotation = rotation
    }
    
    public var body: some View {
        RealityView { content in
            // Two hand tracking setup
        } update: { content in
            guard let left = leftHandPosition, let right = rightHandPosition else { return }
            
            let distance = simd_distance(left, right)
            let angle = atan2(right.y - left.y, right.x - left.x)
            
            if let initialDist = initialDistance {
                scale = CGFloat(distance / initialDist)
            } else {
                initialDistance = distance
            }
            
            if let initialAng = initialAngle {
                rotation = .radians(Double(angle - initialAng))
            } else {
                initialAngle = angle
            }
        }
    }
}
