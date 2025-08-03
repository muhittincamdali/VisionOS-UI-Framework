//
//  SpatialGestures.swift
//  VisionOS-UI-Framework
//
//  Created by Muhittin Camdali
//  Copyright © 2024 Muhittin Camdali. All rights reserved.
//

import SwiftUI
import RealityKit
import Spatial

/// Spatial Gesture Recognition System for VisionOS
@available(visionOS 1.0, *)
public struct SpatialGestures {
    
    /// A spatial tap gesture recognizer for 3D environments
    public struct SpatialTapGesture: ViewModifier {
        private let action: () -> Void
        private let minimumDistance: Double
        private let maximumDistance: Double
        
        public init(
            minimumDistance: Double = 0.1,
            maximumDistance: Double = 2.0,
            action: @escaping () -> Void
        ) {
            self.minimumDistance = minimumDistance
            self.maximumDistance = maximumDistance
            self.action = action
        }
        
        public func body(content: Content) -> some View {
            content
                .gesture(
                    SpatialTapGestureRecognizer(
                        minimumDistance: minimumDistance,
                        maximumDistance: maximumDistance,
                        action: action
                    )
                )
        }
    }
    
    /// A spatial drag gesture recognizer for 3D manipulation
    public struct SpatialDragGesture: ViewModifier {
        private let onChanged: (SpatialDragValue) -> Void
        private let onEnded: (SpatialDragValue) -> Void
        private let minimumDistance: Double
        private let maximumDistance: Double
        
        public init(
            minimumDistance: Double = 0.1,
            maximumDistance: Double = 5.0,
            onChanged: @escaping (SpatialDragValue) -> Void = { _ in },
            onEnded: @escaping (SpatialDragValue) -> Void = { _ in }
        ) {
            self.minimumDistance = minimumDistance
            self.maximumDistance = maximumDistance
            self.onChanged = onChanged
            self.onEnded = onEnded
        }
        
        public func body(content: Content) -> some View {
            content
                .gesture(
                    SpatialDragGestureRecognizer(
                        minimumDistance: minimumDistance,
                        maximumDistance: maximumDistance,
                        onChanged: onChanged,
                        onEnded: onEnded
                    )
                )
        }
    }
    
    /// A spatial pinch gesture recognizer for scaling operations
    public struct SpatialPinchGesture: ViewModifier {
        private let onChanged: (SpatialPinchValue) -> Void
        private let onEnded: (SpatialPinchValue) -> Void
        private let minimumScale: Double
        private let maximumScale: Double
        
        public init(
            minimumScale: Double = 0.1,
            maximumScale: Double = 10.0,
            onChanged: @escaping (SpatialPinchValue) -> Void = { _ in },
            onEnded: @escaping (SpatialPinchValue) -> Void = { _ in }
        ) {
            self.minimumScale = minimumScale
            self.maximumScale = maximumScale
            self.onChanged = onChanged
            self.onEnded = onEnded
        }
        
        public func body(content: Content) -> some View {
            content
                .gesture(
                    SpatialPinchGestureRecognizer(
                        minimumScale: minimumScale,
                        maximumScale: maximumScale,
                        onChanged: onChanged,
                        onEnded: onEnded
                    )
                )
        }
    }
    
    /// A spatial rotation gesture recognizer for 3D rotation
    public struct SpatialRotationGesture: ViewModifier {
        private let onChanged: (SpatialRotationValue) -> Void
        private let onEnded: (SpatialRotationValue) -> Void
        private let minimumRotation: Double
        private let maximumRotation: Double
        
        public init(
            minimumRotation: Double = 0.1,
            maximumRotation: Double = .pi * 2,
            onChanged: @escaping (SpatialRotationValue) -> Void = { _ in },
            onEnded: @escaping (SpatialRotationValue) -> Void = { _ in }
        ) {
            self.minimumRotation = minimumRotation
            self.maximumRotation = maximumRotation
            self.onChanged = onChanged
            self.onEnded = onEnded
        }
        
        public func body(content: Content) -> some View {
            content
                .gesture(
                    SpatialRotationGestureRecognizer(
                        minimumRotation: minimumRotation,
                        maximumRotation: maximumRotation,
                        onChanged: onChanged,
                        onEnded: onEnded
                    )
                )
        }
    }
    
    /// A spatial hover gesture recognizer for hover interactions
    public struct SpatialHoverGesture: ViewModifier {
        private let onEntered: () -> Void
        private let onExited: () -> Void
        private let onMoved: (SpatialHoverValue) -> Void
        private let hoverDistance: Double
        
        public init(
            hoverDistance: Double = 0.5,
            onEntered: @escaping () -> Void = {},
            onExited: @escaping () -> Void = {},
            onMoved: @escaping (SpatialHoverValue) -> Void = { _ in }
        ) {
            self.hoverDistance = hoverDistance
            self.onEntered = onEntered
            self.onExited = onExited
            self.onMoved = onMoved
        }
        
        public func body(content: Content) -> some View {
            content
                .gesture(
                    SpatialHoverGestureRecognizer(
                        hoverDistance: hoverDistance,
                        onEntered: onEntered,
                        onExited: onExited,
                        onMoved: onMoved
                    )
                )
        }
    }
    
    /// A spatial long press gesture recognizer for context menus
    public struct SpatialLongPressGesture: ViewModifier {
        private let minimumDuration: Double
        private let maximumDistance: Double
        private let action: () -> Void
        
        public init(
            minimumDuration: Double = 0.5,
            maximumDistance: Double = 0.2,
            action: @escaping () -> Void
        ) {
            self.minimumDuration = minimumDuration
            self.maximumDistance = maximumDistance
            self.action = action
        }
        
        public func body(content: Content) -> some View {
            content
                .gesture(
                    SpatialLongPressGestureRecognizer(
                        minimumDuration: minimumDuration,
                        maximumDistance: maximumDistance,
                        action: action
                    )
                )
        }
    }
}

// MARK: - Supporting Types

@available(visionOS 1.0, *)
public struct SpatialDragValue {
    public let translation: [Double]
    public let velocity: [Double]
    public let startLocation: [Double]
    public let currentLocation: [Double]
    public let distance: Double
    
    public init(
        translation: [Double],
        velocity: [Double],
        startLocation: [Double],
        currentLocation: [Double],
        distance: Double
    ) {
        self.translation = translation
        self.velocity = velocity
        self.startLocation = startLocation
        self.currentLocation = currentLocation
        self.distance = distance
    }
}

@available(visionOS 1.0, *)
public struct SpatialPinchValue {
    public let scale: Double
    public let velocity: Double
    public let startScale: Double
    public let currentScale: Double
    
    public init(
        scale: Double,
        velocity: Double,
        startScale: Double,
        currentScale: Double
    ) {
        self.scale = scale
        self.velocity = velocity
        self.startScale = startScale
        self.currentScale = currentScale
    }
}

@available(visionOS 1.0, *)
public struct SpatialRotationValue {
    public let rotation: Double
    public let velocity: Double
    public let startRotation: Double
    public let currentRotation: Double
    
    public init(
        rotation: Double,
        velocity: Double,
        startRotation: Double,
        currentRotation: Double
    ) {
        self.rotation = rotation
        self.velocity = velocity
        self.startRotation = startRotation
        self.currentRotation = currentRotation
    }
}

@available(visionOS 1.0, *)
public struct SpatialHoverValue {
    public let location: [Double]
    public let distance: Double
    public let velocity: [Double]
    
    public init(
        location: [Double],
        distance: Double,
        velocity: [Double]
    ) {
        self.location = location
        self.distance = distance
        self.velocity = velocity
    }
}

// MARK: - Gesture Recognizers

@available(visionOS 1.0, *)
private struct SpatialTapGestureRecognizer: Gesture {
    private let minimumDistance: Double
    private let maximumDistance: Double
    private let action: () -> Void
    
    init(
        minimumDistance: Double,
        maximumDistance: Double,
        action: @escaping () -> Void
    ) {
        self.minimumDistance = minimumDistance
        self.maximumDistance = maximumDistance
        self.action = action
    }
    
    var body: some Gesture {
        SpatialTapGesture()
            .onEnded { _ in
                action()
            }
    }
}

@available(visionOS 1.0, *)
private struct SpatialDragGestureRecognizer: Gesture {
    private let minimumDistance: Double
    private let maximumDistance: Double
    private let onChanged: (SpatialDragValue) -> Void
    private let onEnded: (SpatialDragValue) -> Void
    
    init(
        minimumDistance: Double,
        maximumDistance: Double,
        onChanged: @escaping (SpatialDragValue) -> Void,
        onEnded: @escaping (SpatialDragValue) -> Void
    ) {
        self.minimumDistance = minimumDistance
        self.maximumDistance = maximumDistance
        self.onChanged = onChanged
        self.onEnded = onEnded
    }
    
    var body: some Gesture {
        SpatialDragGesture()
            .onChanged { value in
                let dragValue = SpatialDragValue(
                    translation: [value.translation.x, value.translation.y, value.translation.z],
                    velocity: [value.velocity.x, value.velocity.y, value.velocity.z],
                    startLocation: [value.startLocation.x, value.startLocation.y, value.startLocation.z],
                    currentLocation: [value.location.x, value.location.y, value.location.z],
                    distance: value.translation.magnitude
                )
                onChanged(dragValue)
            }
            .onEnded { value in
                let dragValue = SpatialDragValue(
                    translation: [value.translation.x, value.translation.y, value.translation.z],
                    velocity: [value.velocity.x, value.velocity.y, value.velocity.z],
                    startLocation: [value.startLocation.x, value.startLocation.y, value.startLocation.z],
                    currentLocation: [value.location.x, value.location.y, value.location.z],
                    distance: value.translation.magnitude
                )
                onEnded(dragValue)
            }
    }
}

@available(visionOS 1.0, *)
private struct SpatialPinchGestureRecognizer: Gesture {
    private let minimumScale: Double
    private let maximumScale: Double
    private let onChanged: (SpatialPinchValue) -> Void
    private let onEnded: (SpatialPinchValue) -> Void
    
    init(
        minimumScale: Double,
        maximumScale: Double,
        onChanged: @escaping (SpatialPinchValue) -> Void,
        onEnded: @escaping (SpatialPinchValue) -> Void
    ) {
        self.minimumScale = minimumScale
        self.maximumScale = maximumScale
        self.onChanged = onChanged
        self.onEnded = onEnded
    }
    
    var body: some Gesture {
        SpatialMagnificationGesture()
            .onChanged { value in
                let pinchValue = SpatialPinchValue(
                    scale: value.magnification,
                    velocity: value.velocity,
                    startScale: value.startLocation,
                    currentScale: value.location
                )
                onChanged(pinchValue)
            }
            .onEnded { value in
                let pinchValue = SpatialPinchValue(
                    scale: value.magnification,
                    velocity: value.velocity,
                    startScale: value.startLocation,
                    currentScale: value.location
                )
                onEnded(pinchValue)
            }
    }
}

@available(visionOS 1.0, *)
private struct SpatialRotationGestureRecognizer: Gesture {
    private let minimumRotation: Double
    private let maximumRotation: Double
    private let onChanged: (SpatialRotationValue) -> Void
    private let onEnded: (SpatialRotationValue) -> Void
    
    init(
        minimumRotation: Double,
        maximumRotation: Double,
        onChanged: @escaping (SpatialRotationValue) -> Void,
        onEnded: @escaping (SpatialRotationValue) -> Void
    ) {
        self.minimumRotation = minimumRotation
        self.maximumRotation = maximumRotation
        self.onChanged = onChanged
        self.onEnded = onEnded
    }
    
    var body: some Gesture {
        SpatialRotationGesture()
            .onChanged { value in
                let rotationValue = SpatialRotationValue(
                    rotation: value.rotation,
                    velocity: value.velocity,
                    startRotation: value.startLocation,
                    currentRotation: value.location
                )
                onChanged(rotationValue)
            }
            .onEnded { value in
                let rotationValue = SpatialRotationValue(
                    rotation: value.rotation,
                    velocity: value.velocity,
                    startRotation: value.startLocation,
                    currentRotation: value.location
                )
                onEnded(rotationValue)
            }
    }
}

@available(visionOS 1.0, *)
private struct SpatialHoverGestureRecognizer: Gesture {
    private let hoverDistance: Double
    private let onEntered: () -> Void
    private let onExited: () -> Void
    private let onMoved: (SpatialHoverValue) -> Void
    
    init(
        hoverDistance: Double,
        onEntered: @escaping () -> Void,
        onExited: @escaping () -> Void,
        onMoved: @escaping (SpatialHoverValue) -> Void
    ) {
        self.hoverDistance = hoverDistance
        self.onEntered = onEntered
        self.onExited = onExited
        self.onMoved = onMoved
    }
    
    var body: some Gesture {
        SpatialHoverGesture()
            .onChanged { value in
                let hoverValue = SpatialHoverValue(
                    location: [value.location.x, value.location.y, value.location.z],
                    distance: value.location.magnitude,
                    velocity: [value.velocity.x, value.velocity.y, value.velocity.z]
                )
                onMoved(hoverValue)
            }
    }
}

@available(visionOS 1.0, *)
private struct SpatialLongPressGestureRecognizer: Gesture {
    private let minimumDuration: Double
    private let maximumDistance: Double
    private let action: () -> Void
    
    init(
        minimumDuration: Double,
        maximumDistance: Double,
        action: @escaping () -> Void
    ) {
        self.minimumDuration = minimumDuration
        self.maximumDistance = maximumDistance
        self.action = action
    }
    
    var body: some Gesture {
        SpatialLongPressGesture(minimumDuration: minimumDuration)
            .onEnded { _ in
                action()
            }
    }
}

// MARK: - View Extensions

@available(visionOS 1.0, *)
public extension View {
    
    /// Add spatial tap gesture to the view
    func spatialTap(
        minimumDistance: Double = 0.1,
        maximumDistance: Double = 2.0,
        action: @escaping () -> Void
    ) -> some View {
        modifier(SpatialGestures.SpatialTapGesture(
            minimumDistance: minimumDistance,
            maximumDistance: maximumDistance,
            action: action
        ))
    }
    
    /// Add spatial drag gesture to the view
    func spatialDrag(
        minimumDistance: Double = 0.1,
        maximumDistance: Double = 5.0,
        onChanged: @escaping (SpatialDragValue) -> Void = { _ in },
        onEnded: @escaping (SpatialDragValue) -> Void = { _ in }
    ) -> some View {
        modifier(SpatialGestures.SpatialDragGesture(
            minimumDistance: minimumDistance,
            maximumDistance: maximumDistance,
            onChanged: onChanged,
            onEnded: onEnded
        ))
    }
    
    /// Add spatial pinch gesture to the view
    func spatialPinch(
        minimumScale: Double = 0.1,
        maximumScale: Double = 10.0,
        onChanged: @escaping (SpatialPinchValue) -> Void = { _ in },
        onEnded: @escaping (SpatialPinchValue) -> Void = { _ in }
    ) -> some View {
        modifier(SpatialGestures.SpatialPinchGesture(
            minimumScale: minimumScale,
            maximumScale: maximumScale,
            onChanged: onChanged,
            onEnded: onEnded
        ))
    }
    
    /// Add spatial rotation gesture to the view
    func spatialRotation(
        minimumRotation: Double = 0.1,
        maximumRotation: Double = .pi * 2,
        onChanged: @escaping (SpatialRotationValue) -> Void = { _ in },
        onEnded: @escaping (SpatialRotationValue) -> Void = { _ in }
    ) -> some View {
        modifier(SpatialGestures.SpatialRotationGesture(
            minimumRotation: minimumRotation,
            maximumRotation: maximumRotation,
            onChanged: onChanged,
            onEnded: onEnded
        ))
    }
    
    /// Add spatial hover gesture to the view
    func spatialHover(
        hoverDistance: Double = 0.5,
        onEntered: @escaping () -> Void = {},
        onExited: @escaping () -> Void = {},
        onMoved: @escaping (SpatialHoverValue) -> Void = { _ in }
    ) -> some View {
        modifier(SpatialGestures.SpatialHoverGesture(
            hoverDistance: hoverDistance,
            onEntered: onEntered,
            onExited: onExited,
            onMoved: onMoved
        ))
    }
    
    /// Add spatial long press gesture to the view
    func spatialLongPress(
        minimumDuration: Double = 0.5,
        maximumDistance: Double = 0.2,
        action: @escaping () -> Void
    ) -> some View {
        modifier(SpatialGestures.SpatialLongPressGesture(
            minimumDuration: minimumDuration,
            maximumDistance: maximumDistance,
            action: action
        ))
    }
} 