# VisionOS-UI-Framework API Documentation

<!-- TOC START -->
## Table of Contents
- [VisionOS-UI-Framework API Documentation](#visionos-ui-framework-api-documentation)
- [Overview](#overview)
- [Table of Contents](#table-of-contents)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
  - [Requirements](#requirements)
- [Quick Start](#quick-start)
  - [Basic Usage](#basic-usage)
- [Core Components](#core-components)
  - [VisionUI](#visionui)
  - [SpatialContainer](#spatialcontainer)
  - [SpatialButton](#spatialbutton)
  - [SpatialCard](#spatialcard)
  - [SpatialNavigation](#spatialnavigation)
  - [SpatialList](#spatiallist)
  - [SpatialModal](#spatialmodal)
- [Spatial Gestures](#spatial-gestures)
  - [Tap Gesture](#tap-gesture)
  - [Drag Gesture](#drag-gesture)
  - [Pinch Gesture](#pinch-gesture)
  - [Rotation Gesture](#rotation-gesture)
  - [Hover Gesture](#hover-gesture)
  - [Long Press Gesture](#long-press-gesture)
- [Accessibility](#accessibility)
  - [SpatialAccessibility](#spatialaccessibility)
  - [Accessibility Utilities](#accessibility-utilities)
- [Performance](#performance)
  - [PerformanceMonitor](#performancemonitor)
  - [PerformanceMetrics](#performancemetrics)
- [Utilities](#utilities)
  - [SpatialUtilities](#spatialutilities)
  - [SpatialMath](#spatialmath)
  - [SpatialAnimation](#spatialanimation)
  - [SpatialColors](#spatialcolors)
- [Examples](#examples)
  - [Basic Example](#basic-example)
  - [Gesture Example](#gesture-example)
  - [Performance Example](#performance-example)
- [Best Practices](#best-practices)
  - [Performance Optimization](#performance-optimization)
  - [Accessibility](#accessibility)
  - [Spatial Design](#spatial-design)
- [Troubleshooting](#troubleshooting)
  - [Common Issues](#common-issues)
  - [Debugging](#debugging)
- [Support](#support)
<!-- TOC END -->


## Overview

VisionOS-UI-Framework is a comprehensive UI framework for VisionOS providing spatial computing patterns, 3D interface components, and immersive experiences for spatial computing applications.

## Table of Contents

1. [Installation](#installation)
2. [Quick Start](#quick-start)
3. [Core Components](#core-components)
4. [Spatial Gestures](#spatial-gestures)
5. [Accessibility](#accessibility)
6. [Performance](#performance)
7. [Utilities](#utilities)
8. [Examples](#examples)

## Installation

### Swift Package Manager

Add the VisionOS-UI-Framework to your project:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework", from: "1.0.0")
]
```

### Requirements

- **VisionOS**: 1.0+
- **Swift**: 5.9+
- **Xcode**: 15.0+
- **iOS**: 17.0+ (for development)

## Quick Start

### Basic Usage

```swift
import VisionUI

struct ContentView: View {
    var body: some View {
        SpatialContainer {
            SpatialButton("Hello VisionOS") {
                // Handle tap
            }
        }
    }
}
```

## Core Components

### VisionUI

The main framework entry point.

```swift
@available(visionOS 1.0, *)
public struct VisionUI {
    public static let version = "1.0.0"
    public static let buildNumber = "1"
    public static let identifier = "com.muhittincamdali.visionui"
    
    public static func initialize()
}
```

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
        _ title: String,
        style: SpatialButtonStyle = .primary,
        action: @escaping () -> Void
    )
}
```

### SpatialCard

A 3D card component for displaying content.

```swift
@available(visionOS 1.0, *)
public struct SpatialCard<Content: View>: View {
    public init(
        style: SpatialCardStyle = .default,
        @ViewBuilder content: () -> Content
    )
}
```

### SpatialNavigation

A spatial navigation component for 3D environments.

```swift
@available(visionOS 1.0, *)
public struct SpatialNavigation<Content: View>: View {
    public init(
        title: String,
        leadingButton: (() -> AnyView)? = nil,
        trailingButton: (() -> AnyView)? = nil,
        @ViewBuilder content: () -> Content
    )
}
```

### SpatialList

A 3D list component for spatial environments.

```swift
@available(visionOS 1.0, *)
public struct SpatialList<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    public init(
        _ data: Data,
        style: SpatialListStyle = .default,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    )
}
```

### SpatialModal

A 3D modal component for spatial interfaces.

```swift
@available(visionOS 1.0, *)
public struct SpatialModal<Content: View>: View {
    public init(
        isPresented: Binding<Bool>,
        style: SpatialModalStyle = .default,
        @ViewBuilder content: () -> Content
    )
}
```

## Spatial Gestures

### Tap Gesture

```swift
Text("Tap Me")
    .spatialTap {
        // Handle tap
    }
```

### Drag Gesture

```swift
Text("Drag Me")
    .spatialDrag(
        onChanged: { value in
            // Handle drag changes
        },
        onEnded: { value in
            // Handle drag end
        }
    )
```

### Pinch Gesture

```swift
Text("Pinch Me")
    .spatialPinch(
        onChanged: { value in
            // Handle pinch changes
        },
        onEnded: { value in
            // Handle pinch end
        }
    )
```

### Rotation Gesture

```swift
Text("Rotate Me")
    .spatialRotation(
        onChanged: { value in
            // Handle rotation changes
        },
        onEnded: { value in
            // Handle rotation end
        }
    )
```

### Hover Gesture

```swift
Text("Hover Me")
    .spatialHover(
        onEntered: {
            // Handle hover enter
        },
        onExited: {
            // Handle hover exit
        },
        onMoved: { value in
            // Handle hover movement
        }
    )
```

### Long Press Gesture

```swift
Text("Long Press Me")
    .spatialLongPress {
        // Handle long press
    }
```

## Accessibility

### SpatialAccessibility

Comprehensive accessibility support for spatial computing interfaces.

```swift
@available(visionOS 1.0, *)
public struct SpatialAccessibility {
    public struct AccessibilityConfig
    public struct SpatialAccessibilityLabel
    public struct SpatialAccessibilityAction
    public struct SpatialAccessibilityModifier
    public struct SpatialAccessibilityContainer
    public struct SpatialAccessibilityNavigation
    public struct SpatialAccessibilityButton
    public struct SpatialAccessibilityList
    public struct SpatialAccessibilityModal
}
```

### Accessibility Utilities

```swift
@available(visionOS 1.0, *)
public struct SpatialAccessibilityUtilities {
    public static var isVoiceOverRunning: Bool
    public static var isSwitchControlRunning: Bool
    public static var isReduceMotionEnabled: Bool
    public static var isHighContrastEnabled: Bool
    public static var isLargeTextEnabled: Bool
    
    public static func announce(_ message: String)
    public static func focus(_ element: Any)
    public static func getCurrentAccessibilityConfig() -> SpatialAccessibility.AccessibilityConfig
}
```

## Performance

### PerformanceMonitor

Real-time performance monitoring for spatial applications.

```swift
@available(visionOS 1.0, *)
public struct PerformanceMonitor {
    public static var currentFrameRate: Double
    public static var memoryUsage: Double
    public static var spatialTrackingQuality: Double
    
    public static func getPerformanceMetrics() -> PerformanceMetrics
}
```

### PerformanceMetrics

```swift
@available(visionOS 1.0, *)
public struct PerformanceMetrics {
    public let frameRate: Double
    public let memoryUsage: Double
    public let spatialTrackingQuality: Double
    public let renderTime: Double
    public let updateTime: Double
}
```

## Utilities

### SpatialUtilities

Comprehensive utility functions for spatial computing.

```swift
@available(visionOS 1.0, *)
public struct SpatialUtilities {
    public struct SpatialMath
    public struct SpatialAnimation
    public struct SpatialColors
    public struct SpatialDimensions
    public struct SpatialValidation
    public struct SpatialConversion
    public struct SpatialFormatting
    public struct SpatialDebug
}
```

### SpatialMath

Mathematical utilities for 3D spatial computing.

```swift
public struct SpatialMath {
    public static func distance(from point1: [Double], to point2: [Double]) -> Double
    public static func magnitude(_ vector: [Double]) -> Double
    public static func normalize(_ vector: [Double]) -> [Double]
    public static func dotProduct(_ vector1: [Double], _ vector2: [Double]) -> Double
    public static func crossProduct(_ vector1: [Double], _ vector2: [Double]) -> [Double]
}
```

### SpatialAnimation

Animation utilities for spatial interactions.

```swift
public struct SpatialAnimation {
    public static let smooth: Animation
    public static let quick: Animation
    public static let slow: Animation
    public static let spring: Animation
    public static let bounce: Animation
}
```

### SpatialColors

Color utilities for spatial interfaces.

```swift
public struct SpatialColors {
    public static let primaryBlue: Color
    public static let secondaryGray: Color
    public static let successGreen: Color
    public static let warningOrange: Color
    public static let errorRed: Color
    public static let spatialBackground: Color
    public static let spatialSurface: Color
}
```

## Examples

### Basic Example

```swift
import SwiftUI
import VisionUI

struct BasicExample: View {
    @State private var isModalPresented = false
    @State private var buttonTapCount = 0
    
    var body: some View {
        SpatialContainer {
            VStack(spacing: 20) {
                Text("VisionOS UI Framework")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                SpatialButton("Tap Me (\(buttonTapCount))") {
                    buttonTapCount += 1
                }
                
                SpatialCard {
                    Text("Interactive Card")
                    Image(systemName: "star.fill")
                }
                
                SpatialButton("Show Modal") {
                    isModalPresented = true
                }
            }
        }
        .spatialModal(isPresented: $isModalPresented) {
            Text("Modal Content")
        }
    }
}
```

### Gesture Example

```swift
struct GestureExample: View {
    @State private var scale: Double = 1.0
    @State private var rotation: Double = 0.0
    
    var body: some View {
        SpatialContainer {
            Text("Interactive Text")
                .font(.title)
                .scaleEffect(scale)
                .rotationEffect(.radians(rotation))
                .spatialPinch(
                    onChanged: { value in
                        scale = value.scale
                    }
                )
                .spatialRotation(
                    onChanged: { value in
                        rotation = value.rotation
                    }
                )
        }
    }
}
```

### Performance Example

```swift
struct PerformanceExample: View {
    var body: some View {
        SpatialContainer {
            VStack {
                let metrics = PerformanceMonitor.getPerformanceMetrics()
                
                Text("Performance Metrics")
                    .font(.headline)
                
                Text("Frame Rate: \(String(format: "%.1f", metrics.frameRate)) fps")
                Text("Memory Usage: \(String(format: "%.1f", metrics.memoryUsage)) MB")
                Text("Spatial Tracking: \(String(format: "%.2f", metrics.spatialTrackingQuality))")
            }
        }
    }
}
```

## Best Practices

### Performance Optimization

1. **Use SpatialContainer** for all 3D content
2. **Monitor performance** with PerformanceMonitor
3. **Optimize gestures** for smooth interactions
4. **Use appropriate animations** for spatial feedback

### Accessibility

1. **Always provide accessibility labels**
2. **Support VoiceOver** for spatial interfaces
3. **Include accessibility hints** for complex interactions
4. **Test with accessibility features** enabled

### Spatial Design

1. **Consider depth** in spatial layouts
2. **Use appropriate lighting** for 3D elements
3. **Provide clear visual feedback** for interactions
4. **Design for spatial navigation**

## Troubleshooting

### Common Issues

1. **Performance Issues**: Monitor with PerformanceMonitor
2. **Gesture Recognition**: Check gesture parameters
3. **Accessibility**: Verify accessibility labels and hints
4. **Spatial Tracking**: Ensure proper lighting and environment

### Debugging

Use SpatialDebug utilities for debugging:

```swift
SpatialDebug.printDebug("Debug message")
SpatialDebug.logPerformance(metrics)
SpatialDebug.validateEnvironment()
```

## Support

- **GitHub Issues**: [Report Issues](https://github.com/muhittincamdali/VisionOS-UI-Framework/issues)
- **GitHub Discussions**: [Join Discussions](https://github.com/muhittincamdali/VisionOS-UI-Framework/discussions)
- **Documentation**: [API Reference](https://github.com/muhittincamdali/VisionOS-UI-Framework)

---

**Made with ❤️ for the VisionOS community** 