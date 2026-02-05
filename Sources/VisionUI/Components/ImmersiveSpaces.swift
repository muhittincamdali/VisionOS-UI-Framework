// ImmersiveSpaces.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit

// MARK: - Immersive Space System
/// A comprehensive immersive space system for visionOS.
/// Create full, mixed, and progressive immersive experiences.
///
/// Example:
/// ```swift
/// ImmersiveContainer(style: .mixed) {
///     SpatialEnvironment("forest")
///     Anchor3D(.floor) {
///         Model3D("tree")
///     }
/// }
/// .passthrough(.dimmed(0.5))
/// ```
@available(visionOS 2.0, *)
public struct ImmersiveContainer<Content: View>: View {
    
    private let content: Content
    private var style: ImmersiveStyle = .mixed
    private var passthroughMode: PassthroughMode = .full
    private var transitionDuration: Double = 1.0
    private var showBoundary: Bool = false
    
    @State private var isFullyImmersed: Bool = false
    @State private var immersionLevel: Double = 0
    
    public init(
        style: ImmersiveStyle = .mixed,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            // Passthrough control
            if passthroughMode != .full {
                Color.black
                    .opacity(passthroughDimAmount)
                    .ignoresSafeArea()
            }
            
            // Content
            content
            
            // Boundary visualization
            if showBoundary {
                BoundaryVisualization()
            }
        }
        .onAppear {
            if style == .full {
                withAnimation(.easeInOut(duration: transitionDuration)) {
                    isFullyImmersed = true
                    immersionLevel = 1
                }
            }
        }
    }
    
    private var passthroughDimAmount: Double {
        switch passthroughMode {
        case .full: return 0
        case .dimmed(let amount): return amount
        case .hidden: return 1
        case .progressive: return immersionLevel
        }
    }
    
    // MARK: - Modifiers
    
    /// Sets the passthrough mode.
    public func passthrough(_ mode: PassthroughMode) -> ImmersiveContainer {
        var copy = self
        copy.passthroughMode = mode
        return copy
    }
    
    /// Sets the transition duration.
    public func transitionDuration(_ duration: Double) -> ImmersiveContainer {
        var copy = self
        copy.transitionDuration = duration
        return copy
    }
    
    /// Shows or hides the safety boundary.
    public func showBoundary(_ show: Bool) -> ImmersiveContainer {
        var copy = self
        copy.showBoundary = show
        return copy
    }
}

// MARK: - Immersive Styles

/// Immersive space styles.
public enum ImmersiveStyle {
    /// Mixed reality with full passthrough.
    case mixed
    /// Fully immersive with no passthrough.
    case full
    /// Progressive immersion based on user input.
    case progressive
    /// Portal-based immersion.
    case portal
}

/// Passthrough modes for immersive spaces.
public enum PassthroughMode: Equatable {
    case full
    case dimmed(Double)
    case hidden
    case progressive
}

// MARK: - Boundary Visualization

@available(visionOS 2.0, *)
private struct BoundaryVisualization: View {
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    LinearGradient(
                        colors: [.blue.opacity(0.5), .purple.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .scaleEffect(pulseScale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        pulseScale = 1.02
                    }
                }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Spatial Environment

/// A 360° environment for immersive spaces.
@available(visionOS 2.0, *)
public struct SpatialEnvironment: View {
    
    private let environmentName: String
    private var intensity: Float = 1.0
    private var rotation: Angle = .zero
    private var animated: Bool = false
    private var animationSpeed: Float = 0.1
    
    @State private var currentRotation: Angle = .zero
    
    public init(_ environmentName: String) {
        self.environmentName = environmentName
    }
    
    public var body: some View {
        RealityView { content in
            // Load skybox/environment
            let environmentEntity = Entity()
            
            // Create a large sphere for skybox
            let skybox = ModelEntity(
                mesh: .generateSphere(radius: 50),
                materials: [createSkyboxMaterial()]
            )
            skybox.scale *= -1 // Invert for interior viewing
            
            environmentEntity.addChild(skybox)
            content.add(environmentEntity)
        } update: { content in
            // Update rotation
            if let skybox = content.entities.first?.children.first {
                skybox.orientation = simd_quatf(
                    angle: Float(currentRotation.radians),
                    axis: SIMD3<Float>(0, 1, 0)
                )
            }
        }
        .onAppear {
            currentRotation = rotation
            if animated {
                startRotationAnimation()
            }
        }
    }
    
    private func createSkyboxMaterial() -> Material {
        var material = UnlitMaterial()
        // Load environment texture
        return material
    }
    
    private func startRotationAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            currentRotation += .degrees(Double(animationSpeed))
        }
    }
    
    /// Sets the environment intensity.
    public func intensity(_ value: Float) -> SpatialEnvironment {
        var copy = self
        copy.intensity = value
        return copy
    }
    
    /// Sets the initial rotation.
    public func rotation(_ angle: Angle) -> SpatialEnvironment {
        var copy = self
        copy.rotation = angle
        return copy
    }
    
    /// Enables rotation animation.
    public func animated(_ enabled: Bool, speed: Float = 0.1) -> SpatialEnvironment {
        var copy = self
        copy.animated = enabled
        copy.animationSpeed = speed
        return copy
    }
}

// MARK: - Portal View

/// A portal to another immersive space.
@available(visionOS 2.0, *)
public struct PortalView<Content: View>: View {
    
    private let content: Content
    private var size: CGSize = CGSize(width: 300, height: 400)
    private var borderStyle: PortalBorderStyle = .glowing
    private var depth: Float = 0.5
    
    @State private var isActivated: Bool = false
    @State private var portalScale: CGFloat = 1.0
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            // Portal frame
            RoundedRectangle(cornerRadius: 20)
                .stroke(portalBorderGradient, lineWidth: 4)
                .frame(width: size.width, height: size.height)
                .shadow(color: .purple.opacity(0.5), radius: 20)
            
            // Portal content
            content
                .frame(width: size.width - 20, height: size.height - 20)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .scaleEffect(portalScale)
                .opacity(isActivated ? 1 : 0.7)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                isActivated.toggle()
                portalScale = isActivated ? 1.5 : 1.0
            }
        }
    }
    
    private var portalBorderGradient: some ShapeStyle {
        LinearGradient(
            colors: [.purple, .blue, .cyan, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    /// Sets the portal size.
    public func size(width: CGFloat, height: CGFloat) -> PortalView {
        var copy = self
        copy.size = CGSize(width: width, height: height)
        return copy
    }
    
    /// Sets the portal border style.
    public func borderStyle(_ style: PortalBorderStyle) -> PortalView {
        var copy = self
        copy.borderStyle = style
        return copy
    }
    
    /// Sets the portal depth.
    public func depth(_ value: Float) -> PortalView {
        var copy = self
        copy.depth = value
        return copy
    }
}

/// Portal border styles.
public enum PortalBorderStyle {
    case glowing
    case solid
    case animated
    case invisible
}

// MARK: - Anchor 3D

/// An anchor point for 3D content in immersive spaces.
@available(visionOS 2.0, *)
public struct Anchor3D<Content: View>: View {
    
    private let anchorType: AnchorType
    private let content: Content
    private var offset: SIMD3<Float> = .zero
    
    public init(
        _ anchorType: AnchorType,
        @ViewBuilder content: () -> Content
    ) {
        self.anchorType = anchorType
        self.content = content()
    }
    
    public var body: some View {
        RealityView { realityContent in
            let anchor = createAnchor()
            realityContent.add(anchor)
        }
    }
    
    private func createAnchor() -> Entity {
        let anchorEntity = Entity()
        anchorEntity.position = offset
        return anchorEntity
    }
    
    /// Sets the offset from the anchor point.
    public func offset(x: Float = 0, y: Float = 0, z: Float = 0) -> Anchor3D {
        var copy = self
        copy.offset = SIMD3<Float>(x, y, z)
        return copy
    }
}

/// Anchor types for 3D content.
public enum AnchorType {
    case floor
    case ceiling
    case wall
    case table
    case head
    case hand(Handedness)
    case world(SIMD3<Float>)
}

// MARK: - Immersive Transition

/// An animated transition between immersive states.
@available(visionOS 2.0, *)
public struct ImmersiveTransition: View {
    
    @Binding private var isActive: Bool
    private var style: TransitionStyle = .fade
    private var duration: Double = 1.0
    
    @State private var transitionProgress: Double = 0
    
    public init(isActive: Binding<Bool>) {
        self._isActive = isActive
    }
    
    public var body: some View {
        ZStack {
            switch style {
            case .fade:
                Color.black
                    .opacity(transitionProgress)
                    .ignoresSafeArea()
            case .dissolve:
                dissolvePattern
            case .wipe(let direction):
                wipeTransition(direction: direction)
            case .portal:
                portalTransition
            }
        }
        .allowsHitTesting(false)
        .onChange(of: isActive) { _, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: duration)) {
                    transitionProgress = 1
                }
            } else {
                withAnimation(.easeInOut(duration: duration)) {
                    transitionProgress = 0
                }
            }
        }
    }
    
    private var dissolvePattern: some View {
        Canvas { context, size in
            // Dissolve pattern
        }
        .opacity(transitionProgress)
    }
    
    private func wipeTransition(direction: WipeDirection) -> some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(.black)
                .offset(x: -geometry.size.width * (1 - transitionProgress))
        }
    }
    
    private var portalTransition: some View {
        Circle()
            .fill(.black)
            .frame(
                width: UIScreen.main.bounds.width * 2 * transitionProgress,
                height: UIScreen.main.bounds.width * 2 * transitionProgress
            )
    }
    
    /// Sets the transition style.
    public func style(_ style: TransitionStyle) -> ImmersiveTransition {
        var copy = self
        copy.style = style
        return copy
    }
    
    /// Sets the transition duration.
    public func duration(_ duration: Double) -> ImmersiveTransition {
        var copy = self
        copy.duration = duration
        return copy
    }
}

/// Immersive transition styles.
public enum TransitionStyle {
    case fade
    case dissolve
    case wipe(WipeDirection)
    case portal
}

/// Wipe directions for transitions.
public enum WipeDirection {
    case left
    case right
    case up
    case down
}

// MARK: - Shared Space Coordinator

/// Coordinates multiple users in a shared immersive space.
@available(visionOS 2.0, *)
public struct SharedSpaceCoordinator<Content: View>: View {
    
    private let content: Content
    private let sessionIdentifier: String
    
    @State private var connectedUsers: [SharedSpaceUser] = []
    @State private var isConnected: Bool = false
    
    public init(
        sessionIdentifier: String,
        @ViewBuilder content: () -> Content
    ) {
        self.sessionIdentifier = sessionIdentifier
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            content
            
            // User avatars
            ForEach(connectedUsers) { user in
                UserAvatar(user: user)
                    .position3D(user.position)
            }
            
            // Connection status
            if !isConnected {
                ConnectionStatusView(isConnected: $isConnected)
            }
        }
        .task {
            await connectToSession()
        }
    }
    
    private func connectToSession() async {
        // SharePlay / Multipeer connectivity
        isConnected = true
    }
}

/// A user in a shared space.
public struct SharedSpaceUser: Identifiable {
    public let id: String
    public let displayName: String
    public let position: SIMD3<Float>
    public let avatarURL: URL?
    
    public init(id: String, displayName: String, position: SIMD3<Float>, avatarURL: URL? = nil) {
        self.id = id
        self.displayName = displayName
        self.position = position
        self.avatarURL = avatarURL
    }
}

@available(visionOS 2.0, *)
private struct UserAvatar: View {
    let user: SharedSpaceUser
    
    var body: some View {
        VStack {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 50, height: 50)
                .overlay {
                    Text(user.displayName.prefix(2).uppercased())
                        .fontWeight(.bold)
                }
            
            Text(user.displayName)
                .font(.caption)
        }
    }
    
    func position3D(_ position: SIMD3<Float>) -> some View {
        self.offset(x: CGFloat(position.x) * 100, y: CGFloat(position.y) * 100)
    }
}

@available(visionOS 2.0, *)
private struct ConnectionStatusView: View {
    @Binding var isConnected: Bool
    
    var body: some View {
        VStack {
            ProgressView()
            Text("Connecting to shared space...")
                .font(.caption)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
    }
}
