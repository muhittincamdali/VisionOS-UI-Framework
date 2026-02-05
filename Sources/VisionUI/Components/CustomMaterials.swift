// CustomMaterials.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit

// MARK: - Custom Materials System
/// A comprehensive custom materials system for visionOS.
/// Create stunning glass, holographic, and volumetric effects.
///
/// Example:
/// ```swift
/// Model3D("object")
///     .material(.glass(tint: .blue, opacity: 0.8))
///     .material(.holographic(scanlines: true))
/// ```
@available(visionOS 2.0, *)
public enum SpatialMaterial {
    case glass(tint: Color, opacity: Float, roughness: Float)
    case holographic(color: Color, scanlines: Bool, flicker: Bool)
    case neon(color: Color, intensity: Float, bloom: Bool)
    case metallic(color: Color, roughness: Float, clearcoat: Float)
    case emission(color: Color, intensity: Float)
    case gradient(colors: [Color], direction: GradientDirection)
    case animated(baseColor: Color, animationType: MaterialAnimation)
    case wireframe(color: Color, lineWidth: Float)
    case xray(color: Color, edgeFalloff: Float)
    case toon(baseColor: Color, levels: Int)
    case custom(Material)
}

/// Gradient directions for materials.
public enum GradientDirection {
    case horizontal
    case vertical
    case radial
    case angular
}

/// Animation types for materials.
public enum MaterialAnimation {
    case pulse
    case flow
    case shimmer
    case rainbow
    case breathing
}

// MARK: - Material Factory

/// Factory for creating RealityKit materials.
@available(visionOS 2.0, *)
public struct MaterialFactory {
    
    /// Creates a glass-like material.
    public static func glass(
        tint: Color = .clear,
        opacity: Float = 0.8,
        roughness: Float = 0.1
    ) -> Material {
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: UIColor(tint).withAlphaComponent(CGFloat(opacity)))
        material.roughness = .init(floatLiteral: roughness)
        material.metallic = .init(floatLiteral: 0.0)
        material.blending = .transparent(opacity: .init(floatLiteral: opacity))
        return material
    }
    
    /// Creates a holographic material.
    public static func holographic(
        color: Color = .cyan,
        intensity: Float = 1.0
    ) -> Material {
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: UIColor(color))
        material.emissiveColor = .init(color: UIColor(color))
        material.emissiveIntensity = intensity * 0.5
        material.metallic = .init(floatLiteral: 0.9)
        material.roughness = .init(floatLiteral: 0.1)
        return material
    }
    
    /// Creates a neon glow material.
    public static func neon(
        color: Color,
        intensity: Float = 1.0
    ) -> Material {
        var material = UnlitMaterial()
        material.color = .init(tint: UIColor(color).withAlphaComponent(CGFloat(intensity)))
        return material
    }
    
    /// Creates a metallic material.
    public static func metallic(
        color: Color,
        roughness: Float = 0.3,
        metallic: Float = 1.0
    ) -> Material {
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: UIColor(color))
        material.roughness = .init(floatLiteral: roughness)
        material.metallic = .init(floatLiteral: metallic)
        return material
    }
    
    /// Creates an emissive material.
    public static func emission(
        color: Color,
        intensity: Float = 1.0
    ) -> Material {
        var material = PhysicallyBasedMaterial()
        material.baseColor = .init(tint: UIColor(color))
        material.emissiveColor = .init(color: UIColor(color))
        material.emissiveIntensity = intensity
        return material
    }
    
    /// Creates a simple unlit material.
    public static func unlit(color: Color) -> Material {
        var material = UnlitMaterial()
        material.color = .init(tint: UIColor(color))
        return material
    }
}

// MARK: - Glass Material View

/// A glass material effect for SwiftUI views.
@available(visionOS 2.0, *)
public struct GlassMaterial: ViewModifier {
    
    let tint: Color
    let opacity: Double
    let blur: Double
    let cornerRadius: CGFloat
    
    public init(
        tint: Color = .white,
        opacity: Double = 0.8,
        blur: Double = 10,
        cornerRadius: CGFloat = 16
    ) {
        self.tint = tint
        self.opacity = opacity
        self.blur = blur
        self.cornerRadius = cornerRadius
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(tint.opacity(0.1))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    )
            )
    }
}

@available(visionOS 2.0, *)
extension View {
    /// Applies a glass material effect.
    public func glassMaterial(
        tint: Color = .white,
        opacity: Double = 0.8,
        blur: Double = 10,
        cornerRadius: CGFloat = 16
    ) -> some View {
        modifier(GlassMaterial(
            tint: tint,
            opacity: opacity,
            blur: blur,
            cornerRadius: cornerRadius
        ))
    }
}

// MARK: - Holographic Effect

/// A holographic shimmer effect.
@available(visionOS 2.0, *)
public struct HolographicEffect: ViewModifier {
    
    @State private var phase: CGFloat = 0
    let colors: [Color]
    let speed: Double
    
    public init(
        colors: [Color] = [.cyan, .purple, .pink, .cyan],
        speed: Double = 2.0
    ) {
        self.colors = colors
        self.speed = speed
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                LinearGradient(
                    colors: colors,
                    startPoint: .init(x: phase, y: 0),
                    endPoint: .init(x: phase + 1, y: 1)
                )
                .blendMode(.overlay)
                .opacity(0.5)
            }
            .onAppear {
                withAnimation(.linear(duration: speed).repeatForever(autoreverses: false)) {
                    phase = 2
                }
            }
    }
}

@available(visionOS 2.0, *)
extension View {
    /// Applies a holographic shimmer effect.
    public func holographic(
        colors: [Color] = [.cyan, .purple, .pink, .cyan],
        speed: Double = 2.0
    ) -> some View {
        modifier(HolographicEffect(colors: colors, speed: speed))
    }
}

// MARK: - Neon Glow

/// A neon glow effect.
@available(visionOS 2.0, *)
public struct NeonGlow: ViewModifier {
    
    let color: Color
    let radius: CGFloat
    let intensity: Double
    let animated: Bool
    
    @State private var glowOpacity: Double = 1.0
    
    public init(
        color: Color = .cyan,
        radius: CGFloat = 20,
        intensity: Double = 1.0,
        animated: Bool = true
    ) {
        self.color = color
        self.radius = radius
        self.intensity = intensity
        self.animated = animated
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(intensity * glowOpacity), radius: radius)
            .shadow(color: color.opacity(intensity * 0.5 * glowOpacity), radius: radius * 2)
            .shadow(color: color.opacity(intensity * 0.25 * glowOpacity), radius: radius * 3)
            .onAppear {
                if animated {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        glowOpacity = 0.6
                    }
                }
            }
    }
}

@available(visionOS 2.0, *)
extension View {
    /// Applies a neon glow effect.
    public func neonGlow(
        color: Color = .cyan,
        radius: CGFloat = 20,
        intensity: Double = 1.0,
        animated: Bool = true
    ) -> some View {
        modifier(NeonGlow(
            color: color,
            radius: radius,
            intensity: intensity,
            animated: animated
        ))
    }
}

// MARK: - Animated Gradient

/// An animated gradient background.
@available(visionOS 2.0, *)
public struct AnimatedGradient: View {
    
    let colors: [Color]
    let speed: Double
    
    @State private var start: UnitPoint = .topLeading
    @State private var end: UnitPoint = .bottomTrailing
    
    public init(
        colors: [Color] = [.purple, .blue, .cyan],
        speed: Double = 3.0
    ) {
        self.colors = colors
        self.speed = speed
    }
    
    public var body: some View {
        LinearGradient(colors: colors, startPoint: start, endPoint: end)
            .onAppear {
                withAnimation(.easeInOut(duration: speed).repeatForever(autoreverses: true)) {
                    start = .bottomTrailing
                    end = .topLeading
                }
            }
    }
}

// MARK: - Frosted Glass

/// A frosted glass effect with depth.
@available(visionOS 2.0, *)
public struct FrostedGlass: ViewModifier {
    
    let intensity: Double
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    
    public init(
        intensity: Double = 0.5,
        cornerRadius: CGFloat = 20,
        borderWidth: CGFloat = 1
    ) {
        self.intensity = intensity
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    // Blur layer
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                    
                    // Noise texture overlay
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.white.opacity(0.05))
                    
                    // Inner glow
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.5), .white.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: borderWidth
                        )
                }
            )
    }
}

@available(visionOS 2.0, *)
extension View {
    /// Applies a frosted glass effect.
    public func frostedGlass(
        intensity: Double = 0.5,
        cornerRadius: CGFloat = 20,
        borderWidth: CGFloat = 1
    ) -> some View {
        modifier(FrostedGlass(
            intensity: intensity,
            cornerRadius: cornerRadius,
            borderWidth: borderWidth
        ))
    }
}

// MARK: - Volumetric Material

/// A material with volumetric depth effect.
@available(visionOS 2.0, *)
public struct VolumetricMaterial: ViewModifier {
    
    let depth: CGFloat
    let color: Color
    let shadowIntensity: Double
    
    public init(
        depth: CGFloat = 20,
        color: Color = .black,
        shadowIntensity: Double = 0.3
    ) {
        self.depth = depth
        self.color = color
        self.shadowIntensity = shadowIntensity
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(shadowIntensity * 0.5), radius: depth * 0.25, x: 0, y: depth * 0.1)
            .shadow(color: color.opacity(shadowIntensity * 0.3), radius: depth * 0.5, x: 0, y: depth * 0.2)
            .shadow(color: color.opacity(shadowIntensity * 0.2), radius: depth, x: 0, y: depth * 0.4)
    }
}

@available(visionOS 2.0, *)
extension View {
    /// Applies a volumetric depth effect.
    public func volumetricMaterial(
        depth: CGFloat = 20,
        color: Color = .black,
        shadowIntensity: Double = 0.3
    ) -> some View {
        modifier(VolumetricMaterial(
            depth: depth,
            color: color,
            shadowIntensity: shadowIntensity
        ))
    }
}

// MARK: - Energy Field

/// An animated energy field effect.
@available(visionOS 2.0, *)
public struct EnergyField: View {
    
    let color: Color
    let particleCount: Int
    
    @State private var particles: [Particle] = []
    
    public init(color: Color = .cyan, particleCount: Int = 50) {
        self.color = color
        self.particleCount = particleCount
    }
    
    public var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let time = timeline.date.timeIntervalSinceReferenceDate
                
                for particle in particles {
                    let x = (sin(time * particle.speed + particle.phase) + 1) / 2 * size.width
                    let y = (cos(time * particle.speed * 0.7 + particle.phase) + 1) / 2 * size.height
                    
                    let rect = CGRect(
                        x: x - particle.size / 2,
                        y: y - particle.size / 2,
                        width: particle.size,
                        height: particle.size
                    )
                    
                    context.fill(
                        Circle().path(in: rect),
                        with: .color(color.opacity(particle.opacity))
                    )
                }
            }
        }
        .onAppear {
            particles = (0..<particleCount).map { _ in
                Particle(
                    size: CGFloat.random(in: 2...8),
                    speed: Double.random(in: 0.5...2.0),
                    phase: Double.random(in: 0...(.pi * 2)),
                    opacity: Double.random(in: 0.3...1.0)
                )
            }
        }
    }
    
    private struct Particle {
        let size: CGFloat
        let speed: Double
        let phase: Double
        let opacity: Double
    }
}

// MARK: - Scan Line Effect

/// A retro scan line effect.
@available(visionOS 2.0, *)
public struct ScanLineEffect: ViewModifier {
    
    let lineSpacing: CGFloat
    let lineOpacity: Double
    let animated: Bool
    
    @State private var offset: CGFloat = 0
    
    public init(
        lineSpacing: CGFloat = 4,
        lineOpacity: Double = 0.3,
        animated: Bool = true
    ) {
        self.lineSpacing = lineSpacing
        self.lineOpacity = lineOpacity
        self.animated = animated
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                Canvas { context, size in
                    let lines = Int(size.height / lineSpacing)
                    for i in 0..<lines {
                        let y = CGFloat(i) * lineSpacing + (animated ? offset : 0)
                        let rect = CGRect(x: 0, y: y, width: size.width, height: 1)
                        context.fill(
                            Path(rect),
                            with: .color(.black.opacity(lineOpacity))
                        )
                    }
                }
            }
            .onAppear {
                if animated {
                    withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                        offset = lineSpacing
                    }
                }
            }
    }
}

@available(visionOS 2.0, *)
extension View {
    /// Applies a scan line effect.
    public func scanLines(
        spacing: CGFloat = 4,
        opacity: Double = 0.3,
        animated: Bool = true
    ) -> some View {
        modifier(ScanLineEffect(
            lineSpacing: spacing,
            lineOpacity: opacity,
            animated: animated
        ))
    }
}
