# Spatial UI API

## Overview

The Spatial UI API provides comprehensive tools for creating and managing spatial user interface components in VisionOS applications. This API enables developers to build immersive 3D interfaces that respond to spatial interactions.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Core Components](#core-components)
- [Spatial Windows](#spatial-windows)
- [3D Components](#3d-components)
- [Spatial Layouts](#spatial-layouts)
- [Depth Management](#depth-management)
- [Spatial Navigation](#spatial-navigation)
- [Spatial Typography](#spatial-typography)
- [Spatial Colors](#spatial-colors)
- [Spatial Animations](#spatial-animations)
- [Configuration](#configuration)
- [Error Handling](#error-handling)
- [Examples](#examples)

## Installation

### Swift Package Manager

Add the VisionOS UI Framework to your project:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
]
```

### Requirements

- **VisionOS**: 1.0+
- **Swift**: 5.9+
- **Xcode**: 15.0+
- **iOS**: 17.0+ (for development)

## Quick Start

### Basic Import

```swift
import VisionUI
```

### Create Spatial Container

```swift
@available(visionOS 1.0, *)
struct ContentView: View {
    var body: some View {
        SpatialContainer {
            VStack(spacing: 20) {
                Text("Spatial UI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                SpatialButton("Hello VisionOS") {
                    // Handle tap
                }
            }
        }
    }
}
```

## Core Components

### SpatialContainer

A container that provides spatial context for 3D UI elements.

```swift
@available(visionOS 1.0, *)
public struct SpatialContainer<Content: View>: View {
    public init(
        lighting: SpatialLighting = .defaultLighting,
        physics: PhysicsConfiguration = .defaultPhysics,
        audio: SpatialAudioConfiguration = .defaultAudio,
        @ViewBuilder content: () -> Content
    )
}
```

### SpatialButton

A 3D button designed for spatial interaction.

```swift
@available(visionOS 1.0, *)
public struct SpatialButton: View {
    public init(
        title: String,
        position: SpatialPosition = SpatialPosition(x: 0, y: 0, z: -1),
        size: CGSize = CGSize(width: 200, height: 60),
        action: @escaping () -> Void
    )
    
    public func configure(_ configuration: (SpatialButtonConfiguration) -> Void) -> Self
}
```

### SpatialCard

A 3D card component for displaying content in spatial space.

```swift
@available(visionOS 1.0, *)
public struct SpatialCard<Content: View>: View {
    public init(
        title: String? = nil,
        position: SpatialPosition = SpatialPosition(x: 0, y: 0, z: -1),
        size: CGSize = CGSize(width: 300, height: 200),
        @ViewBuilder content: () -> Content
    )
    
    public func configure(_ configuration: (SpatialCardConfiguration) -> Void) -> Self
}
```

### SpatialText

A 3D text component for spatial typography.

```swift
@available(visionOS 1.0, *)
public struct SpatialText: View {
    public init(
        content: String,
        position: SpatialPosition = SpatialPosition(x: 0, y: 0, z: -1),
        fontSize: CGFloat = 24,
        color: Color = .white
    )
    
    public func configure(_ configuration: (SpatialTextConfiguration) -> Void) -> Self
}
```

## Spatial Windows

### SpatialWindow

A floating window in 3D space.

```swift
@available(visionOS 1.0, *)
public struct SpatialWindow {
    public init(
        title: String,
        size: CGSize,
        position: SpatialPosition = SpatialPosition(x: 0, y: 1.5, z: -2)
    )
    
    public func configure(_ configuration: (SpatialWindowConfiguration) -> Void) -> Self
    
    public func addContent(_ content: SpatialContentView) -> Self
}
```

### SpatialWindowManager

Manages multiple spatial windows.

```swift
@available(visionOS 1.0, *)
public class SpatialWindowManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: SpatialWindowConfiguration)
    
    public func addWindow(_ window: SpatialWindow)
    
    public func removeWindow(_ window: SpatialWindow)
    
    public func arrangeWindows(layout: SpatialWindowLayout)
}
```

### SpatialWindowConfiguration

Configuration for spatial windows.

```swift
@available(visionOS 1.0, *)
public struct SpatialWindowConfiguration {
    public var enableFloatingWindows: Bool = true
    public var enableSpatialLayout: Bool = true
    public var enableDepthManagement: Bool = true
    public var enableSpatialNavigation: Bool = true
    public var enableDragging: Bool = true
    public var enableResizing: Bool = true
    public var enableDepthAdjustment: Bool = true
    public var enableSpatialAudio: Bool = true
}
```

## 3D Components

### SpatialComponentManager

Manages 3D spatial components.

```swift
@available(visionOS 1.0, *)
public class SpatialComponentManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: SpatialComponentConfiguration)
    
    public func addSpatialButton(_ button: SpatialButton)
    
    public func addSpatialCard(_ card: SpatialCard)
    
    public func addSpatialText(_ text: SpatialText)
    
    public func removeComponent(_ component: SpatialComponent)
}
```

### SpatialComponentConfiguration

Configuration for spatial components.

```swift
@available(visionOS 1.0, *)
public struct SpatialComponentConfiguration {
    public var enable3DComponents: Bool = true
    public var enableSpatialLayout: Bool = true
    public var enableDepthManagement: Bool = true
    public var enableSpatialInteraction: Bool = true
    public var enableHoverEffects: Bool = true
    public var enablePressEffects: Bool = true
    public var enableSpatialAudio: Bool = true
    public var enableHapticFeedback: Bool = true
}
```

### SpatialButtonConfiguration

Configuration for spatial buttons.

```swift
@available(visionOS 1.0, *)
public struct SpatialButtonConfiguration {
    public var enableHoverEffects: Bool = true
    public var enablePressEffects: Bool = true
    public var enableSpatialAudio: Bool = true
    public var enableHapticFeedback: Bool = true
    public var hoverScale: CGFloat = 1.1
    public var pressScale: CGFloat = 0.95
    public var animationDuration: TimeInterval = 0.2
}
```

### SpatialCardConfiguration

Configuration for spatial cards.

```swift
@available(visionOS 1.0, *)
public struct SpatialCardConfiguration {
    public var enableDepth: Bool = true
    public var enableShadows: Bool = true
    public var enableSpatialAudio: Bool = true
    public var enableAccessibility: Bool = true
    public var cornerRadius: CGFloat = 12
    public var shadowRadius: CGFloat = 8
    public var shadowOpacity: Float = 0.3
}
```

### SpatialTextConfiguration

Configuration for spatial text.

```swift
@available(visionOS 1.0, *)
public struct SpatialTextConfiguration {
    public var enableDepth: Bool = true
    public var enableShadows: Bool = true
    public var enableSpatialAudio: Bool = true
    public var enableAccessibility: Bool = true
    public var shadowRadius: CGFloat = 2
    public var shadowOpacity: Float = 0.5
    public var outlineWidth: CGFloat = 0
    public var outlineColor: Color = .clear
}
```

## Spatial Layouts

### SpatialGridLayout

Grid-based layout for spatial components.

```swift
@available(visionOS 1.0, *)
public struct SpatialGridLayout {
    public init(
        columns: Int,
        rows: Int,
        spacing: CGFloat = 0.3
    )
    
    public func addComponent(_ component: SpatialComponent, at position: GridPosition)
    
    public func applyLayout()
}
```

### SpatialCircularLayout

Circular layout for spatial components.

```swift
@available(visionOS 1.0, *)
public struct SpatialCircularLayout {
    public init(
        radius: CGFloat = 2.0,
        center: SpatialPosition = SpatialPosition(x: 0, y: 0, z: -2)
    )
    
    public func addComponent(_ component: SpatialComponent, at angle: Double)
    
    public func applyLayout()
}
```

### SpatialStackLayout

Stack-based layout for spatial components.

```swift
@available(visionOS 1.0, *)
public struct SpatialStackLayout {
    public enum Axis {
        case horizontal
        case vertical
        case depth
    }
    
    public init(
        axis: Axis = .vertical,
        spacing: CGFloat = 0.2
    )
    
    public func addComponent(_ component: SpatialComponent)
    
    public func applyLayout()
}
```

## Depth Management

### SpatialDepthManager

Manages depth and Z-index of spatial components.

```swift
@available(visionOS 1.0, *)
public class SpatialDepthManager: ObservableObject {
    public init()
    
    public func setDepth(_ component: SpatialComponent, depth: Double)
    
    public func autoArrangeByDepth()
    
    public func bringToFront(_ component: SpatialComponent)
    
    public func sendToBack(_ component: SpatialComponent)
}
```

### SpatialOcclusionManager

Handles object occlusion in spatial space.

```swift
@available(visionOS 1.0, *)
public class SpatialOcclusionManager: ObservableObject {
    public var enableOcclusionDetection: Bool = true
    
    public func onOcclusionDetected(_ handler: @escaping (SpatialComponent) -> Void)
    
    public func onOcclusionResolved(_ handler: @escaping (SpatialComponent) -> Void)
}
```

## Spatial Navigation

### SpatialNavigation

Provides navigation between spatial points.

```swift
@available(visionOS 1.0, *)
public class SpatialNavigation: ObservableObject {
    public init()
    
    public func addNavigationPoint(_ point: SpatialNavigationPoint)
    
    public func navigateToPoint(_ name: String)
    
    public func getCurrentPosition() -> SpatialPosition
    
    public func getNavigationPath(to point: String) -> [SpatialPosition]
}
```

### SpatialNavigationPoint

Represents a navigation point in spatial space.

```swift
@available(visionOS 1.0, *)
public struct SpatialNavigationPoint {
    public let position: SpatialPosition
    public let name: String
    public let description: String?
    
    public init(
        position: SpatialPosition,
        name: String,
        description: String? = nil
    )
}
```

### SpatialWayfinding

Provides wayfinding functionality in spatial environments.

```swift
@available(visionOS 1.0, *)
public class SpatialWayfinding: ObservableObject {
    public init()
    
    public func addWaypoint(_ waypoint: SpatialWaypoint)
    
    public func startWayfinding()
    
    public func stopWayfinding()
    
    public func getNextWaypoint() -> SpatialWaypoint?
}
```

### SpatialWaypoint

Represents a waypoint in spatial navigation.

```swift
@available(visionOS 1.0, *)
public struct SpatialWaypoint {
    public let position: SpatialPosition
    public let description: String
    public let isRequired: Bool
    
    public init(
        position: SpatialPosition,
        description: String,
        isRequired: Bool = true
    )
}
```

## Spatial Typography

### SpatialTextRenderer

Renders 3D text in spatial space.

```swift
@available(visionOS 1.0, *)
public class SpatialTextRenderer: ObservableObject {
    public init()
    
    public func configure(_ configuration: (SpatialTextRendererConfiguration) -> Void)
    
    public func renderText(
        _ text: String,
        position: SpatialPosition,
        fontSize: CGFloat,
        color: Color
    ) -> SpatialText
}
```

### SpatialTextRendererConfiguration

Configuration for text rendering.

```swift
@available(visionOS 1.0, *)
public struct SpatialTextRendererConfiguration {
    public var enableDepth: Bool = true
    public var enableShadows: Bool = true
    public var enableSpatialAudio: Bool = true
    public var enableAccessibility: Bool = true
    public var shadowRadius: CGFloat = 2
    public var shadowOpacity: Float = 0.5
}
```

### SpatialTextScaler

Scales text based on distance and perspective.

```swift
@available(visionOS 1.0, *)
public class SpatialTextScaler: ObservableObject {
    public init()
    
    public func configure(_ configuration: (SpatialTextScalerConfiguration) -> Void)
    
    public func applyScaling(_ text: SpatialText)
    
    public func getOptimalScale(for distance: Double) -> CGFloat
}
```

### SpatialTextScalerConfiguration

Configuration for text scaling.

```swift
@available(visionOS 1.0, *)
public struct SpatialTextScalerConfiguration {
    public var minScale: CGFloat = 0.5
    public var maxScale: CGFloat = 2.0
    public var optimalDistance: Double = 1.0
    public var enableAutoScaling: Bool = true
}
```

## Spatial Colors

### SpatialColorManager

Manages colors in spatial environments.

```swift
@available(visionOS 1.0, *)
public class SpatialColorManager: ObservableObject {
    public init()
    
    public func applyColor(_ color: SpatialColor, to component: SpatialComponent)
    
    public func getContrastColor(for color: SpatialColor) -> SpatialColor
    
    public func createGradient(from startColor: SpatialColor, to endColor: SpatialColor) -> SpatialGradient
}
```

### SpatialColor

Represents a color in spatial space.

```swift
@available(visionOS 1.0, *)
public struct SpatialColor {
    public let red: Double
    public let green: Double
    public let blue: Double
    public let alpha: Double
    
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0)
}
```

### SpatialLightingManager

Manages lighting in spatial environments.

```swift
@available(visionOS 1.0, *)
public class SpatialLightingManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: (SpatialLightingConfiguration) -> Void)
    
    public func addLightSource(_ lightSource: SpatialLightSource)
    
    public func removeLightSource(_ lightSource: SpatialLightSource)
    
    public func updateLighting()
}
```

### SpatialLightingConfiguration

Configuration for spatial lighting.

```swift
@available(visionOS 1.0, *)
public struct SpatialLightingConfiguration {
    public var enableAmbientLighting: Bool = true
    public var enableDirectionalLighting: Bool = true
    public var enablePointLighting: Bool = true
    public var enableShadows: Bool = true
    public var ambientIntensity: Double = 0.3
    public var directionalIntensity: Double = 1.0
}
```

### SpatialLightSource

Represents a light source in spatial space.

```swift
@available(visionOS 1.0, *)
public struct SpatialLightSource {
    public let position: SpatialPosition
    public let intensity: Double
    public let color: SpatialColor
    public let type: LightType
    
    public enum LightType {
        case ambient
        case directional
        case point
        case spot
    }
    
    public init(
        position: SpatialPosition,
        intensity: Double,
        color: SpatialColor,
        type: LightType
    )
}
```

## Spatial Animations

### SpatialAnimationManager

Manages animations in spatial environments.

```swift
@available(visionOS 1.0, *)
public class SpatialAnimationManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: (SpatialAnimationConfiguration) -> Void)
    
    public func applyAnimation(_ animation: SpatialAnimation, to component: SpatialComponent)
    
    public func stopAnimation(for component: SpatialComponent)
    
    public func pauseAnimation(for component: SpatialComponent)
    
    public func resumeAnimation(for component: SpatialComponent)
}
```

### SpatialAnimationConfiguration

Configuration for spatial animations.

```swift
@available(visionOS 1.0, *)
public struct SpatialAnimationConfiguration {
    public var enableSmoothTransitions: Bool = true
    public var enablePhysicsBasedAnimation: Bool = true
    public var enableSpatialAudio: Bool = true
    public var enableHapticFeedback: Bool = true
    public var defaultDuration: TimeInterval = 0.5
    public var defaultEasing: Easing = .easeInOut
}
```

### SpatialAnimation

Represents an animation in spatial space.

```swift
@available(visionOS 1.0, *)
public struct SpatialAnimation {
    public let duration: TimeInterval
    public let easing: Easing
    public let animation: (SpatialComponent) -> Void
    
    public enum Easing {
        case linear
        case easeIn
        case easeOut
        case easeInOut
        case spring
    }
    
    public init(
        duration: TimeInterval,
        easing: Easing,
        animation: @escaping (SpatialComponent) -> Void
    )
}
```

### SpatialTransitionManager

Manages transitions between spatial views.

```swift
@available(visionOS 1.0, *)
public class SpatialTransitionManager: ObservableObject {
    public init()
    
    public func applyTransition(
        _ transition: SpatialTransition,
        from: SpatialView,
        to: SpatialView
    )
    
    public func cancelTransition()
}
```

### SpatialTransition

Represents a transition between spatial views.

```swift
@available(visionOS 1.0, *)
public struct SpatialTransition {
    public let type: TransitionType
    public let direction: TransitionDirection
    public let duration: TimeInterval
    
    public enum TransitionType {
        case fade
        case slide
        case scale
        case rotate
        case custom
    }
    
    public enum TransitionDirection {
        case left
        case right
        case up
        case down
        case forward
        case backward
    }
    
    public init(
        type: TransitionType,
        direction: TransitionDirection,
        duration: TimeInterval
    )
}
```

## Configuration

### Global Configuration

```swift
// Configure spatial UI globally
let spatialUIConfig = SpatialUIConfiguration()
spatialUIConfig.enableSpatialUI = true
spatialUIConfig.enable3DComponents = true
spatialUIConfig.enableSpatialLayout = true
spatialUIConfig.enableDepthManagement = true
spatialUIConfig.enableSpatialNavigation = true
spatialUIConfig.enableSpatialTypography = true
spatialUIConfig.enableSpatialColors = true
spatialUIConfig.enableSpatialAnimations = true

// Apply global configuration
SpatialUI.configure(spatialUIConfig)
```

### Component-Specific Configuration

```swift
// Configure specific components
let buttonConfig = SpatialButtonConfiguration()
buttonConfig.enableHoverEffects = true
buttonConfig.enablePressEffects = true
buttonConfig.enableSpatialAudio = true
buttonConfig.enableHapticFeedback = true

let cardConfig = SpatialCardConfiguration()
cardConfig.enableDepth = true
cardConfig.enableShadows = true
cardConfig.enableSpatialAudio = true
cardConfig.enableAccessibility = true

let textConfig = SpatialTextConfiguration()
textConfig.enableDepth = true
textConfig.enableShadows = true
textConfig.enableSpatialAudio = true
textConfig.enableAccessibility = true
```

## Error Handling

### Error Types

```swift
public enum SpatialUIError: Error {
    case initializationFailed
    case configurationError
    case componentCreationError
    case layoutError
    case animationError
    case navigationError
    case depthError
    case colorError
    case typographyError
}
```

### Error Handling Example

```swift
// Handle spatial UI errors
do {
    let spatialButton = try SpatialButton(
        title: "Test Button",
        position: SpatialPosition(x: 0, y: 0, z: -1)
    )
    
    spatialButton.configure { config in
        config.enableHoverEffects = true
        config.enablePressEffects = true
    }
    
} catch SpatialUIError.initializationFailed {
    print("❌ Spatial UI initialization failed")
} catch SpatialUIError.configurationError {
    print("❌ Configuration error")
} catch SpatialUIError.componentCreationError {
    print("❌ Component creation failed")
} catch {
    print("❌ Unknown error: \(error)")
}
```

## Examples

### Complete Spatial UI Example

```swift
import SwiftUI
import VisionUI

@available(visionOS 1.0, *)
struct SpatialUIExample: View {
    @StateObject private var spatialWindowManager = SpatialWindowManager()
    @StateObject private var componentManager = SpatialComponentManager()
    @StateObject private var depthManager = SpatialDepthManager()
    
    var body: some View {
        SpatialContainer {
            VStack(spacing: 20) {
                Text("Spatial UI Example")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                SpatialButton("Create Window") {
                    createSpatialWindow()
                }
                
                SpatialButton("Add Components") {
                    addSpatialComponents()
                }
                
                SpatialButton("Apply Layout") {
                    applySpatialLayout()
                }
                
                SpatialButton("Manage Depth") {
                    manageDepth()
                }
            }
        }
        .onAppear {
            setupSpatialUI()
        }
    }
    
    private func setupSpatialUI() {
        // Configure spatial window manager
        let windowConfig = SpatialWindowConfiguration()
        windowConfig.enableFloatingWindows = true
        windowConfig.enableSpatialLayout = true
        windowConfig.enableDepthManagement = true
        windowConfig.enableSpatialNavigation = true
        
        spatialWindowManager.configure(windowConfig)
        
        // Configure component manager
        let componentConfig = SpatialComponentConfiguration()
        componentConfig.enable3DComponents = true
        componentConfig.enableSpatialLayout = true
        componentConfig.enableDepthManagement = true
        componentConfig.enableSpatialInteraction = true
        
        componentManager.configure(componentConfig)
    }
    
    private func createSpatialWindow() {
        let floatingWindow = SpatialWindow(
            title: "Spatial App",
            size: CGSize(width: 800, height: 600),
            position: SpatialPosition(x: 0, y: 1.5, z: -2)
        )
        
        floatingWindow.configure { config in
            config.enableDragging = true
            config.enableResizing = true
            config.enableDepthAdjustment = true
            config.enableSpatialAudio = true
        }
        
        spatialWindowManager.addWindow(floatingWindow)
        print("✅ Spatial window created")
    }
    
    private func addSpatialComponents() {
        let spatialButton = SpatialButton(
            title: "Spatial Button",
            position: SpatialPosition(x: 0, y: 0, z: -1),
            size: CGSize(width: 200, height: 60)
        )
        
        spatialButton.configure { config in
            config.enableHoverEffects = true
            config.enablePressEffects = true
            config.enableSpatialAudio = true
            config.enableHapticFeedback = true
        }
        
        componentManager.addSpatialButton(button: spatialButton)
        print("✅ Spatial button added")
    }
    
    private func applySpatialLayout() {
        let gridLayout = SpatialGridLayout(
            columns: 2,
            rows: 2,
            spacing: 0.3
        )
        
        gridLayout.applyLayout()
        print("✅ Spatial layout applied")
    }
    
    private func manageDepth() {
        depthManager.autoArrangeByDepth()
        print("✅ Depth management applied")
    }
}
```

This comprehensive Spatial UI API documentation provides all the necessary information for developers to create effective spatial user interfaces in VisionOS applications.
