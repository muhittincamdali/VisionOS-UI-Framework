// SpatialCarousel.swift
// VisionOS UI Framework - World's #1 VisionOS UI Component Library
// Copyright (c) 2024 Muhittin Camdali. MIT License.

import SwiftUI
import RealityKit
import RealityKitContent

// MARK: - Spatial Carousel
/// A 3D carousel component that displays items in a circular arrangement in space.
/// Perfect for showcasing products, photos, or any 3D content in immersive environments.
///
/// Example:
/// ```swift
/// SpatialCarousel(items: products) { product in
///     ProductCard(product: product)
/// }
/// .radius(2.0)
/// .autoRotate(speed: 0.5)
/// .itemSpacing(.degrees(45))
/// ```
@available(visionOS 2.0, *)
public struct SpatialCarousel<Item: Identifiable, Content: View>: View {
    
    // MARK: - Properties
    
    private let items: [Item]
    private let content: (Item) -> Content
    private var radius: Float = 1.5
    private var autoRotateSpeed: Float = 0.0
    private var itemSpacing: Angle = .degrees(30)
    private var verticalOffset: Float = 0.0
    private var tiltAngle: Angle = .zero
    private var enableHaptics: Bool = true
    private var selectionStyle: CarouselSelectionStyle = .scale
    
    @State private var currentIndex: Int = 0
    @State private var rotation: Angle = .zero
    @State private var isDragging: Bool = false
    @State private var dragVelocity: CGFloat = 0
    
    // MARK: - Initialization
    
    /// Creates a new spatial carousel with the specified items.
    /// - Parameters:
    ///   - items: The array of items to display in the carousel.
    ///   - content: A view builder that creates the view for each item.
    public init(items: [Item], @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.content = content
    }
    
    // MARK: - Body
    
    public var body: some View {
        TimelineView(.animation) { timeline in
            RealityView { content in
                let carouselAnchor = AnchorEntity()
                
                for (index, item) in items.enumerated() {
                    let angle = Double(index) * itemSpacing.radians
                    let x = radius * Float(cos(angle))
                    let z = radius * Float(sin(angle))
                    
                    let itemEntity = Entity()
                    itemEntity.position = SIMD3<Float>(x, verticalOffset, z)
                    itemEntity.name = "carousel_item_\(index)"
                    
                    // Face toward center
                    let lookAtCenter = simd_quatf(angle: Float(angle) + .pi, axis: SIMD3<Float>(0, 1, 0))
                    itemEntity.orientation = lookAtCenter
                    
                    carouselAnchor.addChild(itemEntity)
                }
                
                content.add(carouselAnchor)
            } update: { content in
                // Update rotation based on auto-rotate or user interaction
                if let carouselAnchor = content.entities.first {
                    let totalRotation = Float(rotation.radians)
                    carouselAnchor.orientation = simd_quatf(angle: totalRotation, axis: SIMD3<Float>(0, 1, 0))
                }
            }
            .gesture(carouselDragGesture)
            .gesture(carouselTapGesture)
            .onChange(of: timeline.date) { _, _ in
                if !isDragging && autoRotateSpeed > 0 {
                    withAnimation(.linear(duration: 0.016)) {
                        rotation += .degrees(Double(autoRotateSpeed) * 0.016)
                    }
                }
            }
        }
    }
    
    // MARK: - Gestures
    
    private var carouselDragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                isDragging = true
                let delta = value.translation.width / 200
                rotation += .degrees(Double(delta))
                dragVelocity = value.velocity.width
            }
            .onEnded { _ in
                isDragging = false
                // Apply momentum
                withAnimation(.easeOut(duration: 1.0)) {
                    rotation += .degrees(Double(dragVelocity) / 50)
                }
                
                if enableHaptics {
                    triggerHapticFeedback()
                }
            }
    }
    
    private var carouselTapGesture: some Gesture {
        SpatialTapGesture()
            .onEnded { value in
                // Navigate to tapped item
                if enableHaptics {
                    triggerSelectionHaptic()
                }
            }
    }
    
    // MARK: - Haptics
    
    private func triggerHapticFeedback() {
        #if os(visionOS)
        // visionOS haptic feedback
        #endif
    }
    
    private func triggerSelectionHaptic() {
        #if os(visionOS)
        // Selection haptic
        #endif
    }
    
    // MARK: - Modifiers
    
    /// Sets the radius of the carousel.
    public func radius(_ value: Float) -> SpatialCarousel {
        var copy = self
        copy.radius = value
        return copy
    }
    
    /// Enables auto-rotation with the specified speed.
    public func autoRotate(speed: Float) -> SpatialCarousel {
        var copy = self
        copy.autoRotateSpeed = speed
        return copy
    }
    
    /// Sets the angular spacing between items.
    public func itemSpacing(_ angle: Angle) -> SpatialCarousel {
        var copy = self
        copy.itemSpacing = angle
        return copy
    }
    
    /// Sets the vertical offset for all items.
    public func verticalOffset(_ offset: Float) -> SpatialCarousel {
        var copy = self
        copy.verticalOffset = offset
        return copy
    }
    
    /// Tilts the entire carousel.
    public func tilt(_ angle: Angle) -> SpatialCarousel {
        var copy = self
        copy.tiltAngle = angle
        return copy
    }
    
    /// Enables or disables haptic feedback.
    public func haptics(_ enabled: Bool) -> SpatialCarousel {
        var copy = self
        copy.enableHaptics = enabled
        return copy
    }
    
    /// Sets the selection style for items.
    public func selectionStyle(_ style: CarouselSelectionStyle) -> SpatialCarousel {
        var copy = self
        copy.selectionStyle = style
        return copy
    }
}

// MARK: - Selection Style

/// The visual style applied to selected items in the carousel.
public enum CarouselSelectionStyle {
    /// Scales up the selected item.
    case scale
    /// Highlights with a glow effect.
    case glow
    /// Moves the selected item forward.
    case pop
    /// Adds a border highlight.
    case border
    /// No selection effect.
    case none
}

// MARK: - Carousel Item Protocol

/// Protocol for items that can be displayed in a spatial carousel.
public protocol SpatialCarouselItem: Identifiable {
    associatedtype PreviewContent: View
    
    /// The 3D content to display for this item.
    @ViewBuilder var carouselPreview: PreviewContent { get }
    
    /// Optional depth offset for layering.
    var depthOffset: Float { get }
}

extension SpatialCarouselItem {
    public var depthOffset: Float { 0 }
}

// MARK: - Convenience Initializers

@available(visionOS 2.0, *)
extension SpatialCarousel where Item: SpatialCarouselItem, Content == Item.PreviewContent {
    /// Creates a carousel using the item's built-in preview content.
    public init(items: [Item]) {
        self.items = items
        self.content = { $0.carouselPreview }
    }
}

// MARK: - 3D Card Carousel Preset

/// A pre-configured carousel optimized for displaying cards in 3D space.
@available(visionOS 2.0, *)
public struct CardCarousel3D<Item: Identifiable>: View {
    private let items: [Item]
    private let cardWidth: CGFloat
    private let cardHeight: CGFloat
    private let titleKeyPath: KeyPath<Item, String>?
    private let imageKeyPath: KeyPath<Item, String>?
    
    public init(
        items: [Item],
        cardWidth: CGFloat = 300,
        cardHeight: CGFloat = 400,
        title: KeyPath<Item, String>? = nil,
        image: KeyPath<Item, String>? = nil
    ) {
        self.items = items
        self.cardWidth = cardWidth
        self.cardHeight = cardHeight
        self.titleKeyPath = title
        self.imageKeyPath = image
    }
    
    public var body: some View {
        SpatialCarousel(items: items) { item in
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .frame(width: cardWidth, height: cardHeight)
                .overlay {
                    VStack {
                        if let imagePath = imageKeyPath {
                            Image(item[keyPath: imagePath])
                                .resizable()
                                .scaledToFill()
                                .frame(height: cardHeight * 0.7)
                                .clipped()
                        }
                        
                        if let titlePath = titleKeyPath {
                            Text(item[keyPath: titlePath])
                                .font(.headline)
                                .padding()
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .radius(2.0)
        .itemSpacing(.degrees(45))
    }
}

// MARK: - Photo Gallery Carousel

/// A carousel specifically designed for photo galleries in immersive spaces.
@available(visionOS 2.0, *)
public struct PhotoGalleryCarousel: View {
    private let photos: [URL]
    @State private var selectedPhoto: URL?
    
    public init(photos: [URL]) {
        self.photos = photos
    }
    
    public var body: some View {
        SpatialCarousel(items: photos.enumerated().map { PhotoItem(id: $0.offset, url: $0.element) }) { item in
            AsyncImage(url: item.url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 10)
            } placeholder: {
                ProgressView()
            }
        }
        .radius(3.0)
        .autoRotate(speed: 0.1)
    }
    
    private struct PhotoItem: Identifiable {
        let id: Int
        let url: URL
    }
}
