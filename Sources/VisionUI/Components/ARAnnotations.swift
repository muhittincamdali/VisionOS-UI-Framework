// ARAnnotations.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit
import ARKit

// MARK: - AR Annotation System
/// A comprehensive AR annotation system for visionOS.
/// Place labels, callouts, and information panels in 3D space.
///
/// Example:
/// ```swift
/// AnnotationView {
///     Annotation3D(at: objectPosition) {
///         Label("Product Name", systemImage: "tag")
///     }
///     .style(.callout)
///     .connector(.curved)
/// }
/// ```
@available(visionOS 2.0, *)
public struct AnnotationView<Content: View>: View {
    
    private let content: Content
    private var showConnectors: Bool = true
    private var animateOnAppear: Bool = true
    private var clusterOverlapping: Bool = true
    
    @State private var annotations: [AnnotationData] = []
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            content
        }
    }
    
    /// Shows or hides connectors between annotations and anchors.
    public func showConnectors(_ show: Bool) -> AnnotationView {
        var copy = self
        copy.showConnectors = show
        return copy
    }
    
    /// Enables or disables appear animation.
    public func animateOnAppear(_ animate: Bool) -> AnnotationView {
        var copy = self
        copy.animateOnAppear = animate
        return copy
    }
    
    /// Clusters overlapping annotations.
    public func clusterOverlapping(_ cluster: Bool) -> AnnotationView {
        var copy = self
        copy.clusterOverlapping = cluster
        return copy
    }
}

// MARK: - Annotation Data

private struct AnnotationData: Identifiable {
    let id = UUID()
    var position: SIMD3<Float>
    var isVisible: Bool
    var priority: Int
}

// MARK: - 3D Annotation

/// A 3D annotation placed at a specific position in space.
@available(visionOS 2.0, *)
public struct Annotation3D<Content: View>: View {
    
    private let position: SIMD3<Float>
    private let content: Content
    private var style: AnnotationStyle = .label
    private var connectorStyle: ConnectorStyle = .straight
    private var billboarding: Bool = true
    private var maxDistance: Float = 10.0
    private var fadeWithDistance: Bool = true
    
    @State private var isExpanded: Bool = false
    @State private var distanceToCamera: Float = 0
    
    public init(
        at position: SIMD3<Float>,
        @ViewBuilder content: () -> Content
    ) {
        self.position = position
        self.content = content()
    }
    
    public var body: some View {
        RealityView { realityContent in
            let annotationAnchor = Entity()
            annotationAnchor.position = position
            realityContent.add(annotationAnchor)
        } update: { realityContent in
            // Update billboarding if enabled
        }
        .overlay {
            annotationContent
                .opacity(opacity)
                .scaleEffect(scale)
        }
    }
    
    @ViewBuilder
    private var annotationContent: some View {
        switch style {
        case .label:
            labelStyle
        case .callout:
            calloutStyle
        case .bubble:
            bubbleStyle
        case .minimal:
            minimalStyle
        case .custom(let customView):
            AnyView(customView)
        }
    }
    
    private var labelStyle: some View {
        content
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
            )
    }
    
    private var calloutStyle: some View {
        VStack(spacing: 0) {
            content
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                )
            
            // Callout arrow
            Triangle()
                .fill(.ultraThinMaterial)
                .frame(width: 20, height: 10)
        }
    }
    
    private var bubbleStyle: some View {
        content
            .padding(12)
            .background(
                Circle()
                    .fill(.ultraThinMaterial)
            )
    }
    
    private var minimalStyle: some View {
        content
            .font(.caption)
    }
    
    private var opacity: Double {
        if fadeWithDistance {
            return Double(1 - (distanceToCamera / maxDistance))
        }
        return 1
    }
    
    private var scale: CGFloat {
        if fadeWithDistance {
            return CGFloat(1 - (distanceToCamera / maxDistance) * 0.3)
        }
        return 1
    }
    
    // MARK: - Modifiers
    
    /// Sets the annotation style.
    public func style(_ style: AnnotationStyle) -> Annotation3D {
        var copy = self
        copy.style = style
        return copy
    }
    
    /// Sets the connector style.
    public func connector(_ style: ConnectorStyle) -> Annotation3D {
        var copy = self
        copy.connectorStyle = style
        return copy
    }
    
    /// Enables or disables billboarding.
    public func billboarding(_ enabled: Bool) -> Annotation3D {
        var copy = self
        copy.billboarding = enabled
        return copy
    }
    
    /// Sets the maximum visible distance.
    public func maxDistance(_ distance: Float) -> Annotation3D {
        var copy = self
        copy.maxDistance = distance
        return copy
    }
    
    /// Enables or disables distance fading.
    public func fadeWithDistance(_ fade: Bool) -> Annotation3D {
        var copy = self
        copy.fadeWithDistance = fade
        return copy
    }
}

// MARK: - Annotation Styles

/// Visual styles for annotations.
public enum AnnotationStyle {
    case label
    case callout
    case bubble
    case minimal
    case custom(AnyView)
}

/// Connector styles for annotations.
public enum ConnectorStyle {
    case straight
    case curved
    case dashed
    case animated
    case none
}

// MARK: - Triangle Shape

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Object Label

/// A label that attaches to a 3D object.
@available(visionOS 2.0, *)
public struct ObjectLabel: View {
    
    private let title: String
    private let subtitle: String?
    private let icon: String?
    private var showOnHover: Bool = true
    private var placement: LabelPlacement = .top
    
    @State private var isVisible: Bool = false
    
    public init(
        _ title: String,
        subtitle: String? = nil,
        icon: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.caption)
                }
                
                Text(title)
                    .font(.headline)
            }
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
        )
        .opacity(isVisible ? 1 : 0)
        .scaleEffect(isVisible ? 1 : 0.8)
        .onHover { hovering in
            if showOnHover {
                withAnimation(.spring(response: 0.3)) {
                    isVisible = hovering
                }
            }
        }
        .onAppear {
            if !showOnHover {
                isVisible = true
            }
        }
    }
    
    /// Sets whether the label shows on hover.
    public func showOnHover(_ show: Bool) -> ObjectLabel {
        var copy = self
        copy.showOnHover = show
        return copy
    }
    
    /// Sets the label placement relative to the object.
    public func placement(_ placement: LabelPlacement) -> ObjectLabel {
        var copy = self
        copy.placement = placement
        return copy
    }
}

/// Label placement options.
public enum LabelPlacement {
    case top
    case bottom
    case leading
    case trailing
    case center
    case floating
}

// MARK: - Info Hotspot

/// An interactive hotspot that reveals information on tap.
@available(visionOS 2.0, *)
public struct InfoHotspot<Content: View>: View {
    
    private let content: Content
    private var icon: String = "info.circle.fill"
    private var size: CGFloat = 30
    private var color: Color = .accentColor
    private var pulseAnimation: Bool = true
    
    @State private var isExpanded: Bool = false
    @State private var pulseScale: CGFloat = 1.0
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            // Hotspot indicator
            ZStack {
                if pulseAnimation {
                    Circle()
                        .fill(color.opacity(0.3))
                        .frame(width: size * pulseScale, height: size * pulseScale)
                }
                
                Circle()
                    .fill(color)
                    .frame(width: size, height: size)
                
                Image(systemName: icon)
                    .font(.system(size: size * 0.5))
                    .foregroundStyle(.white)
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            }
            
            // Expanded content
            if isExpanded {
                content
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                    )
                    .offset(y: -80)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear {
            if pulseAnimation {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    pulseScale = 1.3
                }
            }
        }
    }
    
    /// Sets the hotspot icon.
    public func icon(_ name: String) -> InfoHotspot {
        var copy = self
        copy.icon = name
        return copy
    }
    
    /// Sets the hotspot size.
    public func size(_ value: CGFloat) -> InfoHotspot {
        var copy = self
        copy.size = value
        return copy
    }
    
    /// Sets the hotspot color.
    public func color(_ value: Color) -> InfoHotspot {
        var copy = self
        copy.color = value
        return copy
    }
    
    /// Enables or disables pulse animation.
    public func pulseAnimation(_ enabled: Bool) -> InfoHotspot {
        var copy = self
        copy.pulseAnimation = enabled
        return copy
    }
}

// MARK: - Measurement Annotation

/// An annotation that displays measurements between two points.
@available(visionOS 2.0, *)
public struct MeasurementAnnotation: View {
    
    private let startPoint: SIMD3<Float>
    private let endPoint: SIMD3<Float>
    private var unit: MeasurementUnit = .meters
    private var showEndpoints: Bool = true
    private var lineColor: Color = .accentColor
    
    public init(from start: SIMD3<Float>, to end: SIMD3<Float>) {
        self.startPoint = start
        self.endPoint = end
    }
    
    public var body: some View {
        RealityView { content in
            let measurementEntity = Entity()
            
            // Line between points
            let distance = simd_distance(startPoint, endPoint)
            let midpoint = (startPoint + endPoint) / 2
            
            let line = ModelEntity(
                mesh: .generateCylinder(height: distance, radius: 0.002),
                materials: [SimpleMaterial(color: UIColor(lineColor), isMetallic: false)]
            )
            
            line.position = midpoint
            
            // Orient line
            let direction = normalize(endPoint - startPoint)
            let up = SIMD3<Float>(0, 1, 0)
            let axis = cross(up, direction)
            if simd_length(axis) > 0.001 {
                let angle = acos(dot(up, direction))
                line.orientation = simd_quatf(angle: angle, axis: normalize(axis))
            }
            
            measurementEntity.addChild(line)
            
            // Endpoints
            if showEndpoints {
                let startSphere = ModelEntity(
                    mesh: .generateSphere(radius: 0.01),
                    materials: [SimpleMaterial(color: UIColor(lineColor), isMetallic: true)]
                )
                startSphere.position = startPoint
                
                let endSphere = ModelEntity(
                    mesh: .generateSphere(radius: 0.01),
                    materials: [SimpleMaterial(color: UIColor(lineColor), isMetallic: true)]
                )
                endSphere.position = endPoint
                
                measurementEntity.addChild(startSphere)
                measurementEntity.addChild(endSphere)
            }
            
            content.add(measurementEntity)
        }
        .overlay {
            // Measurement label
            Text(formattedDistance)
                .font(.caption)
                .padding(4)
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                )
        }
    }
    
    private var formattedDistance: String {
        let distance = simd_distance(startPoint, endPoint)
        switch unit {
        case .meters:
            return String(format: "%.2f m", distance)
        case .centimeters:
            return String(format: "%.1f cm", distance * 100)
        case .feet:
            return String(format: "%.2f ft", distance * 3.28084)
        case .inches:
            return String(format: "%.1f in", distance * 39.3701)
        }
    }
    
    /// Sets the measurement unit.
    public func unit(_ unit: MeasurementUnit) -> MeasurementAnnotation {
        var copy = self
        copy.unit = unit
        return copy
    }
    
    /// Shows or hides endpoint markers.
    public func showEndpoints(_ show: Bool) -> MeasurementAnnotation {
        var copy = self
        copy.showEndpoints = show
        return copy
    }
    
    /// Sets the line color.
    public func lineColor(_ color: Color) -> MeasurementAnnotation {
        var copy = self
        copy.lineColor = color
        return copy
    }
}

/// Measurement units.
public enum MeasurementUnit {
    case meters
    case centimeters
    case feet
    case inches
}

// MARK: - Step by Step Guide

/// A step-by-step AR guide with annotations.
@available(visionOS 2.0, *)
public struct StepByStepGuide: View {
    
    private let steps: [GuideStep]
    @Binding private var currentStep: Int
    private var showProgress: Bool = true
    private var autoAdvance: Bool = false
    
    public init(steps: [GuideStep], currentStep: Binding<Int>) {
        self.steps = steps
        self._currentStep = currentStep
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            // Progress indicator
            if showProgress {
                HStack(spacing: 8) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        Circle()
                            .fill(index <= currentStep ? Color.accentColor : Color.gray.opacity(0.3))
                            .frame(width: 10, height: 10)
                    }
                }
            }
            
            // Current step content
            if currentStep < steps.count {
                VStack(spacing: 12) {
                    Text("Step \(currentStep + 1)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(steps[currentStep].title)
                        .font(.headline)
                    
                    Text(steps[currentStep].description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 16) {
                        if currentStep > 0 {
                            Button("Previous") {
                                withAnimation {
                                    currentStep -= 1
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                        
                        if currentStep < steps.count - 1 {
                            Button("Next") {
                                withAnimation {
                                    currentStep += 1
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            Button("Done") {
                                // Complete
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                )
            }
        }
    }
    
    /// Shows or hides progress indicator.
    public func showProgress(_ show: Bool) -> StepByStepGuide {
        var copy = self
        copy.showProgress = show
        return copy
    }
    
    /// Enables or disables auto-advance.
    public func autoAdvance(_ enabled: Bool) -> StepByStepGuide {
        var copy = self
        copy.autoAdvance = enabled
        return copy
    }
}

/// A step in a guide.
public struct GuideStep: Identifiable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let targetPosition: SIMD3<Float>?
    public let highlightRadius: Float?
    
    public init(
        title: String,
        description: String,
        targetPosition: SIMD3<Float>? = nil,
        highlightRadius: Float? = nil
    ) {
        self.title = title
        self.description = description
        self.targetPosition = targetPosition
        self.highlightRadius = highlightRadius
    }
}
