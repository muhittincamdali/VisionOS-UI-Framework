// VolumeViews.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit

// MARK: - Volume View System
/// A comprehensive volume view system for visionOS.
/// Create volumetric content with automatic sizing and depth management.
///
/// Example:
/// ```swift
/// VolumeContainer(size: .medium) {
///     Model3D("product")
///         .rotatable()
/// }
/// .background(.glass)
/// .showBoundingBox(false)
/// ```
@available(visionOS 2.0, *)
public struct VolumeContainer<Content: View>: View {
    
    private let content: Content
    private var size: VolumeSize = .medium
    private var background: VolumeBackground = .none
    private var showBoundingBox: Bool = false
    private var enableInteraction: Bool = true
    
    @State private var currentRotation: Rotation3D = .identity
    @State private var currentScale: CGFloat = 1.0
    
    public init(
        size: VolumeSize = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.size = size
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            if background != .none {
                volumeBackground
            }
            
            content
                .frame(depth: size.depth)
            
            if showBoundingBox {
                BoundingBoxView(size: size)
            }
        }
        .frame(width: size.width, height: size.height)
        .gesture(enableInteraction ? interactionGestures : nil)
    }
    
    @ViewBuilder
    private var volumeBackground: some View {
        switch background {
        case .none:
            EmptyView()
        case .glass:
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        case .solid(let color):
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
        case .gradient(let colors):
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: colors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }
    
    private var interactionGestures: some Gesture {
        MagnifyGesture()
            .onChanged { value in
                currentScale = value.magnification
            }
    }
    
    // MARK: - Modifiers
    
    /// Sets the volume background.
    public func background(_ background: VolumeBackground) -> VolumeContainer {
        var copy = self
        copy.background = background
        return copy
    }
    
    /// Shows or hides the bounding box.
    public func showBoundingBox(_ show: Bool) -> VolumeContainer {
        var copy = self
        copy.showBoundingBox = show
        return copy
    }
    
    /// Enables or disables user interaction.
    public func interaction(_ enabled: Bool) -> VolumeContainer {
        var copy = self
        copy.enableInteraction = enabled
        return copy
    }
}

// MARK: - Volume Size

/// Predefined volume sizes.
public enum VolumeSize {
    case small
    case medium
    case large
    case custom(width: CGFloat, height: CGFloat, depth: CGFloat)
    
    var width: CGFloat {
        switch self {
        case .small: return 200
        case .medium: return 400
        case .large: return 600
        case .custom(let w, _, _): return w
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small: return 200
        case .medium: return 400
        case .large: return 600
        case .custom(_, let h, _): return h
        }
    }
    
    var depth: CGFloat {
        switch self {
        case .small: return 200
        case .medium: return 400
        case .large: return 600
        case .custom(_, _, let d): return d
        }
    }
}

/// Volume background styles.
public enum VolumeBackground: Equatable {
    case none
    case glass
    case solid(Color)
    case gradient([Color])
    
    public static func == (lhs: VolumeBackground, rhs: VolumeBackground) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none): return true
        case (.glass, .glass): return true
        case (.solid(let a), .solid(let b)): return a == b
        case (.gradient(let a), .gradient(let b)): return a == b
        default: return false
        }
    }
}

// MARK: - Bounding Box View

@available(visionOS 2.0, *)
private struct BoundingBoxView: View {
    let size: VolumeSize
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
            .foregroundStyle(.secondary.opacity(0.5))
            .frame(width: size.width, height: size.height)
    }
}

// MARK: - 3D Model View

/// A view for displaying 3D models with interaction support.
@available(visionOS 2.0, *)
public struct Model3DView: View {
    
    private let modelName: String
    private var scale: Float = 1.0
    private var rotation: simd_quatf = .init()
    private var position: SIMD3<Float> = .zero
    private var enableRotation: Bool = false
    private var enableZoom: Bool = false
    private var autoRotate: Bool = false
    private var autoRotateSpeed: Float = 0.5
    
    @State private var currentRotation: Angle = .zero
    @State private var currentScale: Float = 1.0
    @State private var isDragging: Bool = false
    
    public init(_ modelName: String) {
        self.modelName = modelName
    }
    
    public var body: some View {
        RealityView { content in
            do {
                let entity = try await Entity(named: modelName)
                entity.scale = SIMD3<Float>(repeating: scale * currentScale)
                entity.position = position
                entity.orientation = rotation * simd_quatf(
                    angle: Float(currentRotation.radians),
                    axis: SIMD3<Float>(0, 1, 0)
                )
                content.add(entity)
            } catch {
                // Handle model loading error
                let placeholder = ModelEntity(
                    mesh: .generateBox(size: 0.1),
                    materials: [SimpleMaterial(color: .gray, isMetallic: false)]
                )
                content.add(placeholder)
            }
        } update: { content in
            if let entity = content.entities.first {
                entity.scale = SIMD3<Float>(repeating: scale * currentScale)
                entity.orientation = rotation * simd_quatf(
                    angle: Float(currentRotation.radians),
                    axis: SIMD3<Float>(0, 1, 0)
                )
            }
        }
        .gesture(rotationGesture)
        .gesture(zoomGesture)
        .onAppear {
            if autoRotate {
                startAutoRotation()
            }
        }
    }
    
    private var rotationGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if enableRotation {
                    isDragging = true
                    currentRotation = .degrees(Double(value.translation.width))
                }
            }
            .onEnded { _ in
                isDragging = false
            }
    }
    
    private var zoomGesture: some Gesture {
        MagnifyGesture()
            .onChanged { value in
                if enableZoom {
                    currentScale = Float(value.magnification)
                }
            }
    }
    
    private func startAutoRotation() {
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            if !isDragging {
                currentRotation += .degrees(Double(autoRotateSpeed))
            }
        }
    }
    
    // MARK: - Modifiers
    
    /// Sets the model scale.
    public func scale(_ value: Float) -> Model3DView {
        var copy = self
        copy.scale = value
        return copy
    }
    
    /// Sets the model position.
    public func position(x: Float = 0, y: Float = 0, z: Float = 0) -> Model3DView {
        var copy = self
        copy.position = SIMD3<Float>(x, y, z)
        return copy
    }
    
    /// Enables user rotation.
    public func rotatable(_ enabled: Bool = true) -> Model3DView {
        var copy = self
        copy.enableRotation = enabled
        return copy
    }
    
    /// Enables user zoom.
    public func zoomable(_ enabled: Bool = true) -> Model3DView {
        var copy = self
        copy.enableZoom = enabled
        return copy
    }
    
    /// Enables auto-rotation.
    public func autoRotate(speed: Float = 0.5) -> Model3DView {
        var copy = self
        copy.autoRotate = true
        copy.autoRotateSpeed = speed
        return copy
    }
}

// MARK: - Volumetric Text

/// 3D text with depth and extrusion.
@available(visionOS 2.0, *)
public struct VolumetricText: View {
    
    private let text: String
    private var font: Font = .largeTitle
    private var depth: Float = 0.05
    private var color: Color = .white
    private var extrusionColor: Color = .gray
    private var bevel: Bool = true
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        RealityView { content in
            let textMesh = MeshResource.generateText(
                text,
                extrusionDepth: depth,
                font: .systemFont(ofSize: 0.1),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byWordWrapping
            )
            
            var material = PhysicallyBasedMaterial()
            material.baseColor = .init(tint: UIColor(color))
            material.metallic = .init(floatLiteral: 0.1)
            material.roughness = .init(floatLiteral: 0.3)
            
            let textEntity = ModelEntity(mesh: textMesh, materials: [material])
            content.add(textEntity)
        }
    }
    
    /// Sets the font.
    public func font(_ font: Font) -> VolumetricText {
        var copy = self
        copy.font = font
        return copy
    }
    
    /// Sets the extrusion depth.
    public func depth(_ value: Float) -> VolumetricText {
        var copy = self
        copy.depth = value
        return copy
    }
    
    /// Sets the text color.
    public func color(_ color: Color) -> VolumetricText {
        var copy = self
        copy.color = color
        return copy
    }
    
    /// Enables or disables bevel effect.
    public func bevel(_ enabled: Bool) -> VolumetricText {
        var copy = self
        copy.bevel = enabled
        return copy
    }
}

// MARK: - Turntable View

/// A turntable for displaying 3D content with auto-rotation.
@available(visionOS 2.0, *)
public struct TurntableView<Content: View>: View {
    
    private let content: Content
    private var rotationSpeed: Double = 0.5
    private var axis: RotationAxis = .y
    private var pauseOnInteraction: Bool = true
    
    @State private var rotation: Angle = .zero
    @State private var isPaused: Bool = false
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .rotation3DEffect(
                rotation,
                axis: axis.vector
            )
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        if pauseOnInteraction {
                            isPaused = true
                        }
                    }
                    .onEnded { _ in
                        isPaused = false
                    }
            )
            .onAppear {
                startRotation()
            }
    }
    
    private func startRotation() {
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            if !isPaused {
                rotation += .degrees(rotationSpeed)
            }
        }
    }
    
    /// Sets the rotation speed.
    public func speed(_ value: Double) -> TurntableView {
        var copy = self
        copy.rotationSpeed = value
        return copy
    }
    
    /// Sets the rotation axis.
    public func axis(_ axis: RotationAxis) -> TurntableView {
        var copy = self
        copy.axis = axis
        return copy
    }
    
    /// Pauses rotation on user interaction.
    public func pauseOnInteraction(_ pause: Bool) -> TurntableView {
        var copy = self
        copy.pauseOnInteraction = pause
        return copy
    }
}

/// Rotation axis options.
public enum RotationAxis {
    case x
    case y
    case z
    case custom(x: CGFloat, y: CGFloat, z: CGFloat)
    
    var vector: (x: CGFloat, y: CGFloat, z: CGFloat) {
        switch self {
        case .x: return (1, 0, 0)
        case .y: return (0, 1, 0)
        case .z: return (0, 0, 1)
        case .custom(let x, let y, let z): return (x, y, z)
        }
    }
}

// MARK: - Floating Object

/// An object that floats with subtle animation.
@available(visionOS 2.0, *)
public struct FloatingObject<Content: View>: View {
    
    private let content: Content
    private var amplitude: CGFloat = 10
    private var frequency: Double = 2
    private var enableShadow: Bool = true
    
    @State private var offset: CGFloat = 0
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .offset(y: offset)
            .shadow(
                color: .black.opacity(enableShadow ? 0.2 : 0),
                radius: 20 - offset / 2,
                y: 10 + offset / 2
            )
            .onAppear {
                withAnimation(.easeInOut(duration: frequency).repeatForever(autoreverses: true)) {
                    offset = -amplitude
                }
            }
    }
    
    /// Sets the float amplitude.
    public func amplitude(_ value: CGFloat) -> FloatingObject {
        var copy = self
        copy.amplitude = value
        return copy
    }
    
    /// Sets the float frequency.
    public func frequency(_ value: Double) -> FloatingObject {
        var copy = self
        copy.frequency = value
        return copy
    }
    
    /// Enables or disables the shadow.
    public func shadow(_ enabled: Bool) -> FloatingObject {
        var copy = self
        copy.enableShadow = enabled
        return copy
    }
}

// MARK: - Orbit View

/// Content that orbits around a center point.
@available(visionOS 2.0, *)
public struct OrbitView<Content: View>: View {
    
    private let content: Content
    private var radius: CGFloat = 100
    private var speed: Double = 1
    private var tilt: Angle = .degrees(15)
    
    @State private var angle: Angle = .zero
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .offset(
                x: radius * CGFloat(cos(angle.radians)),
                y: radius * CGFloat(sin(angle.radians)) * CGFloat(cos(tilt.radians))
            )
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
                    angle += .degrees(speed)
                }
            }
    }
    
    /// Sets the orbit radius.
    public func radius(_ value: CGFloat) -> OrbitView {
        var copy = self
        copy.radius = value
        return copy
    }
    
    /// Sets the orbit speed.
    public func speed(_ value: Double) -> OrbitView {
        var copy = self
        copy.speed = value
        return copy
    }
    
    /// Sets the orbit tilt.
    public func tilt(_ angle: Angle) -> OrbitView {
        var copy = self
        copy.tilt = angle
        return copy
    }
}
