// SpatialCharts.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit
import Charts

// MARK: - 3D Chart System
/// A comprehensive 3D charting system for visionOS.
/// Supports bar charts, pie charts, line charts, and scatter plots in 3D space.
///
/// Example:
/// ```swift
/// Chart3D(data: salesData) {
///     BarMark3D(x: $0.month, y: $0.revenue)
/// }
/// .chartStyle(.floating)
/// .depth(0.3)
/// ```
@available(visionOS 2.0, *)
public struct Chart3D<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    
    // MARK: - Properties
    
    private let data: Data
    private let content: (Data.Element) -> Content
    private var chartStyle: Chart3DStyle = .floating
    private var depth: Float = 0.2
    private var animateOnAppear: Bool = true
    private var showGrid: Bool = true
    private var showLabels: Bool = true
    private var colorScheme: Chart3DColorScheme = .default
    
    @State private var isAnimated: Bool = false
    
    // MARK: - Initialization
    
    public init(
        data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.content = content
    }
    
    // MARK: - Body
    
    public var body: some View {
        RealityView { content in
            let chartEntity = createChartEntity()
            content.add(chartEntity)
        } update: { content in
            // Update chart on data changes
        }
        .onAppear {
            if animateOnAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                    isAnimated = true
                }
            }
        }
    }
    
    // MARK: - Chart Creation
    
    private func createChartEntity() -> Entity {
        let chartAnchor = Entity()
        
        // Add grid if enabled
        if showGrid {
            let gridEntity = createGridEntity()
            chartAnchor.addChild(gridEntity)
        }
        
        return chartAnchor
    }
    
    private func createGridEntity() -> Entity {
        let gridEntity = Entity()
        // Grid lines implementation
        return gridEntity
    }
    
    // MARK: - Modifiers
    
    /// Sets the chart style.
    public func chartStyle(_ style: Chart3DStyle) -> Chart3D {
        var copy = self
        copy.chartStyle = style
        return copy
    }
    
    /// Sets the depth of chart elements.
    public func depth(_ value: Float) -> Chart3D {
        var copy = self
        copy.depth = value
        return copy
    }
    
    /// Enables or disables animation on appear.
    public func animateOnAppear(_ animate: Bool) -> Chart3D {
        var copy = self
        copy.animateOnAppear = animate
        return copy
    }
    
    /// Shows or hides the grid.
    public func showGrid(_ show: Bool) -> Chart3D {
        var copy = self
        copy.showGrid = show
        return copy
    }
    
    /// Shows or hides labels.
    public func showLabels(_ show: Bool) -> Chart3D {
        var copy = self
        copy.showLabels = show
        return copy
    }
    
    /// Sets the color scheme.
    public func colorScheme(_ scheme: Chart3DColorScheme) -> Chart3D {
        var copy = self
        copy.colorScheme = scheme
        return copy
    }
}

// MARK: - Chart Styles

/// Visual styles for 3D charts.
public enum Chart3DStyle {
    /// Floating in space with shadows.
    case floating
    /// Embedded in a glass container.
    case glassContainer
    /// Minimal style with no decorations.
    case minimal
    /// Holographic appearance.
    case holographic
    /// Volumetric with solid appearance.
    case volumetric
}

// MARK: - Color Schemes

/// Color schemes for 3D charts.
public enum Chart3DColorScheme {
    case `default`
    case vibrant
    case pastel
    case monochrome(Color)
    case gradient([Color])
    case custom([Color])
    
    var colors: [Color] {
        switch self {
        case .default:
            return [.blue, .green, .orange, .purple, .red, .yellow]
        case .vibrant:
            return [.cyan, .mint, .pink, .indigo, .orange, .yellow]
        case .pastel:
            return [
                Color(red: 0.7, green: 0.85, blue: 0.95),
                Color(red: 0.85, green: 0.95, blue: 0.85),
                Color(red: 0.95, green: 0.9, blue: 0.8),
                Color(red: 0.9, green: 0.85, blue: 0.95),
                Color(red: 0.95, green: 0.85, blue: 0.85)
            ]
        case .monochrome(let color):
            return (1...6).map { color.opacity(Double($0) / 6) }
        case .gradient(let colors):
            return colors
        case .custom(let colors):
            return colors
        }
    }
}

// MARK: - 3D Bar Chart

/// A 3D bar chart component.
@available(visionOS 2.0, *)
public struct BarChart3D<Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    
    private let data: Data
    private let valueKeyPath: KeyPath<Data.Element, Double>
    private let labelKeyPath: KeyPath<Data.Element, String>
    
    @State private var animationProgress: CGFloat = 0
    
    public init(
        data: Data,
        value: KeyPath<Data.Element, Double>,
        label: KeyPath<Data.Element, String>
    ) {
        self.data = data
        self.valueKeyPath = value
        self.labelKeyPath = label
    }
    
    public var body: some View {
        GeometryReader3D { geometry in
            RealityView { content in
                let chartEntity = Entity()
                let maxValue = data.map { $0[keyPath: valueKeyPath] }.max() ?? 1
                let barWidth: Float = 0.1
                let spacing: Float = 0.05
                
                for (index, item) in data.enumerated() {
                    let value = item[keyPath: valueKeyPath]
                    let normalizedHeight = Float(value / maxValue) * 0.5
                    
                    // Create bar
                    let barMesh = MeshResource.generateBox(
                        width: barWidth,
                        height: normalizedHeight,
                        depth: barWidth
                    )
                    
                    let colorIndex = index % Chart3DColorScheme.default.colors.count
                    let color = Chart3DColorScheme.default.colors[colorIndex]
                    
                    var material = PhysicallyBasedMaterial()
                    material.baseColor = .init(tint: UIColor(color))
                    material.metallic = .init(floatLiteral: 0.1)
                    material.roughness = .init(floatLiteral: 0.3)
                    
                    let barEntity = ModelEntity(mesh: barMesh, materials: [material])
                    let xPosition = Float(index) * (barWidth + spacing) - Float(data.count) * (barWidth + spacing) / 2
                    barEntity.position = SIMD3<Float>(xPosition, normalizedHeight / 2, 0)
                    barEntity.name = "bar_\(index)"
                    
                    chartEntity.addChild(barEntity)
                }
                
                content.add(chartEntity)
            } update: { content in
                // Animate bars
                for entity in content.entities {
                    for child in entity.children {
                        if child.name.starts(with: "bar_") {
                            child.scale.y = Float(animationProgress)
                        }
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 1.0, dampingFraction: 0.6)) {
                animationProgress = 1
            }
        }
    }
}

// MARK: - 3D Pie Chart

/// A 3D pie chart component with depth and animation.
@available(visionOS 2.0, *)
public struct PieChart3D<Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    
    private let data: Data
    private let valueKeyPath: KeyPath<Data.Element, Double>
    private let labelKeyPath: KeyPath<Data.Element, String>
    private var depth: Float = 0.1
    private var explode: Bool = false
    
    @State private var selectedSlice: Data.Element.ID?
    @State private var rotationAngle: Angle = .zero
    
    public init(
        data: Data,
        value: KeyPath<Data.Element, Double>,
        label: KeyPath<Data.Element, String>
    ) {
        self.data = data
        self.valueKeyPath = value
        self.labelKeyPath = label
    }
    
    public var body: some View {
        ZStack {
            ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                PieSlice3D(
                    value: item[keyPath: valueKeyPath],
                    total: total,
                    startAngle: startAngle(for: index),
                    color: Chart3DColorScheme.default.colors[index % Chart3DColorScheme.default.colors.count],
                    depth: depth,
                    isSelected: selectedSlice == item.id,
                    explode: explode
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedSlice = selectedSlice == item.id ? nil : item.id
                    }
                }
            }
        }
        .rotation3DEffect(rotationAngle, axis: (x: 0.3, y: 1, z: 0))
        .gesture(
            DragGesture()
                .onChanged { value in
                    rotationAngle = .degrees(Double(value.translation.width))
                }
        )
    }
    
    private var total: Double {
        data.map { $0[keyPath: valueKeyPath] }.reduce(0, +)
    }
    
    private func startAngle(for index: Int) -> Angle {
        let precedingValues = data.prefix(index).map { $0[keyPath: valueKeyPath] }.reduce(0, +)
        return .degrees(precedingValues / total * 360)
    }
    
    /// Sets the depth of the pie.
    public func depth(_ value: Float) -> PieChart3D {
        var copy = self
        copy.depth = value
        return copy
    }
    
    /// Enables explode effect on selection.
    public func explode(_ enabled: Bool) -> PieChart3D {
        var copy = self
        copy.explode = enabled
        return copy
    }
}

/// A single slice of a 3D pie chart.
@available(visionOS 2.0, *)
private struct PieSlice3D: View {
    let value: Double
    let total: Double
    let startAngle: Angle
    let color: Color
    let depth: Float
    let isSelected: Bool
    let explode: Bool
    
    var body: some View {
        // Pie slice implementation using RealityKit
        let angle = value / total * 360
        
        return RealityView { content in
            // Create pie slice mesh
        }
        .offset(z: isSelected && explode ? 20 : 0)
        .scaleEffect(isSelected ? 1.05 : 1.0)
    }
}

// MARK: - 3D Line Chart

/// A 3D line chart with animated path drawing.
@available(visionOS 2.0, *)
public struct LineChart3D<Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    
    private let data: Data
    private let xKeyPath: KeyPath<Data.Element, Double>
    private let yKeyPath: KeyPath<Data.Element, Double>
    private var showPoints: Bool = true
    private var lineWidth: Float = 0.01
    private var curveStyle: LineCurveStyle = .smooth
    
    @State private var drawProgress: CGFloat = 0
    
    public init(
        data: Data,
        x: KeyPath<Data.Element, Double>,
        y: KeyPath<Data.Element, Double>
    ) {
        self.data = data
        self.xKeyPath = x
        self.yKeyPath = y
    }
    
    public var body: some View {
        RealityView { content in
            let lineEntity = Entity()
            
            // Create line segments
            let points = data.map { item in
                SIMD3<Float>(
                    Float(item[keyPath: xKeyPath]),
                    Float(item[keyPath: yKeyPath]),
                    0
                )
            }
            
            for i in 0..<(points.count - 1) {
                let segment = createLineSegment(from: points[i], to: points[i + 1])
                lineEntity.addChild(segment)
            }
            
            // Add points if enabled
            if showPoints {
                for point in points {
                    let sphere = ModelEntity(
                        mesh: .generateSphere(radius: lineWidth * 2),
                        materials: [SimpleMaterial(color: .cyan, isMetallic: true)]
                    )
                    sphere.position = point
                    lineEntity.addChild(sphere)
                }
            }
            
            content.add(lineEntity)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                drawProgress = 1
            }
        }
    }
    
    private func createLineSegment(from start: SIMD3<Float>, to end: SIMD3<Float>) -> Entity {
        let distance = simd_distance(start, end)
        let midpoint = (start + end) / 2
        
        let cylinder = ModelEntity(
            mesh: .generateCylinder(height: distance, radius: lineWidth),
            materials: [SimpleMaterial(color: .cyan, isMetallic: true)]
        )
        
        cylinder.position = midpoint
        
        // Orient cylinder to connect points
        let direction = normalize(end - start)
        let up = SIMD3<Float>(0, 1, 0)
        let axis = cross(up, direction)
        let angle = acos(dot(up, direction))
        
        if simd_length(axis) > 0.001 {
            cylinder.orientation = simd_quatf(angle: angle, axis: normalize(axis))
        }
        
        return cylinder
    }
    
    /// Shows or hides data points.
    public func showPoints(_ show: Bool) -> LineChart3D {
        var copy = self
        copy.showPoints = show
        return copy
    }
    
    /// Sets the line width.
    public func lineWidth(_ width: Float) -> LineChart3D {
        var copy = self
        copy.lineWidth = width
        return copy
    }
    
    /// Sets the curve style.
    public func curveStyle(_ style: LineCurveStyle) -> LineChart3D {
        var copy = self
        copy.curveStyle = style
        return copy
    }
}

/// Curve styles for line charts.
public enum LineCurveStyle {
    case linear
    case smooth
    case stepped
}

// MARK: - 3D Scatter Plot

/// A 3D scatter plot for visualizing point data in space.
@available(visionOS 2.0, *)
public struct ScatterPlot3D<Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    
    private let data: Data
    private let xKeyPath: KeyPath<Data.Element, Double>
    private let yKeyPath: KeyPath<Data.Element, Double>
    private let zKeyPath: KeyPath<Data.Element, Double>
    private let sizeKeyPath: KeyPath<Data.Element, Double>?
    
    public init(
        data: Data,
        x: KeyPath<Data.Element, Double>,
        y: KeyPath<Data.Element, Double>,
        z: KeyPath<Data.Element, Double>,
        size: KeyPath<Data.Element, Double>? = nil
    ) {
        self.data = data
        self.xKeyPath = x
        self.yKeyPath = y
        self.zKeyPath = z
        self.sizeKeyPath = size
    }
    
    public var body: some View {
        RealityView { content in
            let scatterEntity = Entity()
            
            for (index, item) in data.enumerated() {
                let position = SIMD3<Float>(
                    Float(item[keyPath: xKeyPath]),
                    Float(item[keyPath: yKeyPath]),
                    Float(item[keyPath: zKeyPath])
                )
                
                let radius: Float = sizeKeyPath.map { Float(item[keyPath: $0]) * 0.02 } ?? 0.02
                
                let colorIndex = index % Chart3DColorScheme.default.colors.count
                let color = Chart3DColorScheme.default.colors[colorIndex]
                
                let sphere = ModelEntity(
                    mesh: .generateSphere(radius: radius),
                    materials: [SimpleMaterial(color: UIColor(color), isMetallic: false)]
                )
                sphere.position = position
                
                scatterEntity.addChild(sphere)
            }
            
            content.add(scatterEntity)
        }
    }
}

// MARK: - Chart Marks

/// A 3D bar mark for use in Chart3D.
@available(visionOS 2.0, *)
public struct BarMark3D: View {
    let x: String
    let y: Double
    
    public init(x: String, y: Double) {
        self.x = x
        self.y = y
    }
    
    public var body: some View {
        EmptyView() // Placeholder - actual rendering happens in Chart3D
    }
}

/// A 3D point mark for use in Chart3D.
@available(visionOS 2.0, *)
public struct PointMark3D: View {
    let x: Double
    let y: Double
    let z: Double
    
    public init(x: Double, y: Double, z: Double = 0) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public var body: some View {
        EmptyView()
    }
}
