# Getting Started Guide

## Overview

Welcome to the VisionOS UI Framework! This guide will help you get started with creating immersive spatial computing experiences for VisionOS applications.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Basic Setup](#basic-setup)
- [Your First Spatial App](#your-first-spatial-app)
- [Understanding Spatial Computing](#understanding-spatial-computing)
- [Next Steps](#next-steps)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before you begin, ensure you have the following:

### Development Environment

- **Xcode 15.0+**: Latest version of Xcode with VisionOS SDK
- **VisionOS 1.0+**: VisionOS development platform
- **Swift 5.9+**: Latest Swift programming language
- **iOS 17.0+**: For development and testing
- **Git**: Version control system

### Hardware Requirements

- **Apple Vision Pro**: For testing and development
- **Mac with Apple Silicon**: Recommended for optimal performance
- **Sufficient Storage**: At least 10GB free space for development tools

### Knowledge Requirements

- **Swift Programming**: Basic to intermediate Swift knowledge
- **SwiftUI**: Familiarity with SwiftUI framework
- **Spatial Computing Concepts**: Understanding of AR/VR principles
- **3D Graphics**: Basic knowledge of 3D graphics and spatial concepts

## Installation

### Step 1: Clone the Repository

```bash
# Clone the VisionOS UI Framework repository
git clone https://github.com/muhittincamdali/VisionOS-UI-Framework.git

# Navigate to project directory
cd VisionOS-UI-Framework

# Install dependencies
swift package resolve
```

### Step 2: Open in Xcode

```bash
# Open the project in Xcode
open Package.swift
```

### Step 3: Add to Your Project

#### Swift Package Manager

Add the framework to your project's `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
]
```

#### Xcode Project

1. Open your Xcode project
2. Go to **File > Add Package Dependencies**
3. Enter the repository URL: `https://github.com/muhittincamdali/VisionOS-UI-Framework.git`
4. Select the latest version
5. Add the package to your target

## Quick Start

### Basic Import

```swift
import VisionUI
```

### Initialize Framework

```swift
// Initialize VisionOS UI framework manager
let visionOSUIManager = VisionOSUIFrameworkManager()

// Configure VisionOS UI framework
let uiConfig = VisionOSUIFrameworkConfiguration()
uiConfig.enableSpatialUI = true
uiConfig.enableImmersiveExperiences = true
uiConfig.enable3DInteractions = true
uiConfig.enableSpatialAudio = true

// Start VisionOS UI framework manager
visionOSUIManager.start(with: uiConfig)
```

### Create Your First Spatial Component

```swift
// Create a simple spatial button
let spatialButton = SpatialButton(
    title: "Hello VisionOS",
    position: SpatialPosition(x: 0, y: 0, z: -1)
)

// Configure the button
spatialButton.configure { config in
    config.enableHoverEffects = true
    config.enablePressEffects = true
    config.enableSpatialAudio = true
    config.enableHapticFeedback = true
}
```

## Basic Setup

### Project Configuration

1. **Create New VisionOS Project**:
   - Open Xcode
   - Choose **Create a new Xcode project**
   - Select **VisionOS** platform
   - Choose **App** template
   - Configure your project settings

2. **Add Framework Dependencies**:
   ```swift
   dependencies: [
       .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
   ]
   ```

3. **Configure Build Settings**:
   - Set **Deployment Target** to VisionOS 1.0+
   - Enable **Spatial Computing** capabilities
   - Configure **Privacy Permissions** if needed

### Basic App Structure

```swift
import SwiftUI
import VisionUI

@available(visionOS 1.0, *)
struct ContentView: View {
    @StateObject private var frameworkManager = VisionOSUIFrameworkManager()
    
    var body: some View {
        SpatialContainer {
            VStack(spacing: 20) {
                Text("Welcome to VisionOS")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                SpatialButton("Start Experience") {
                    startSpatialExperience()
                }
            }
        }
        .onAppear {
            setupFramework()
        }
    }
    
    private func setupFramework() {
        let config = VisionOSUIFrameworkConfiguration()
        config.enableSpatialUI = true
        config.enableImmersiveExperiences = true
        config.enable3DInteractions = true
        config.enableSpatialAudio = true
        
        frameworkManager.start(with: config)
    }
    
    private func startSpatialExperience() {
        // Your spatial experience logic here
        print("Starting spatial experience...")
    }
}
```

## Your First Spatial App

### Step 1: Create the App Structure

```swift
import SwiftUI
import VisionUI

@available(visionOS 1.0, *)
@main
struct MySpatialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### Step 2: Create the Main View

```swift
@available(visionOS 1.0, *)
struct ContentView: View {
    @StateObject private var frameworkManager = VisionOSUIFrameworkManager()
    @State private var isImmersiveActive = false
    
    var body: some View {
        SpatialContainer {
            VStack(spacing: 30) {
                // Header
                Text("My Spatial App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Welcome to the future of computing")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                // Interactive Buttons
                SpatialButton("Start Immersive Experience") {
                    startImmersiveExperience()
                }
                .spatialTap {
                    // Additional tap handling
                }
                
                SpatialButton("Create Spatial Window") {
                    createSpatialWindow()
                }
                
                SpatialButton("Enable Hand Tracking") {
                    enableHandTracking()
                }
                
                // Status
                Text("Framework Status: \(frameworkManager.status.description)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .onAppear {
            setupFramework()
        }
    }
    
    private func setupFramework() {
        let config = VisionOSUIFrameworkConfiguration()
        config.enableSpatialUI = true
        config.enableImmersiveExperiences = true
        config.enable3DInteractions = true
        config.enableSpatialAudio = true
        config.enableHandTracking = true
        config.enableEyeTracking = true
        
        frameworkManager.start(with: config)
    }
    
    private func startImmersiveExperience() {
        isImmersiveActive = true
        
        // Create immersive space
        let immersiveSpace = ImmersiveSpace(
            name: "Virtual Environment",
            type: .fullImmersive,
            environment: .office
        )
        
        immersiveSpace.configure { config in
            config.enableSpatialAudio = true
            config.enableEnvironmentalLighting = true
            config.enableWeatherEffects = true
        }
        
        print("✅ Immersive experience started")
    }
    
    private func createSpatialWindow() {
        let spatialWindow = SpatialWindow(
            title: "Spatial Window",
            size: CGSize(width: 600, height: 400),
            position: SpatialPosition(x: 0, y: 1.5, z: -2)
        )
        
        spatialWindow.configure { config in
            config.enableDragging = true
            config.enableResizing = true
            config.enableDepthAdjustment = true
        }
        
        print("✅ Spatial window created")
    }
    
    private func enableHandTracking() {
        let handTracking = HandTracking(
            enableBothHands: true,
            enableFingerTracking: true
        )
        
        handTracking.configure { config in
            config.enableGestureRecognition = true
            config.enableHapticFeedback = true
        }
        
        print("✅ Hand tracking enabled")
    }
}
```

### Step 3: Add Immersive Experience

```swift
@available(visionOS 1.0, *)
struct ImmersiveView: View {
    @StateObject private var immersiveManager = ImmersiveSpaceManager()
    
    var body: some View {
        RealityView { content in
            // Add 3D content to immersive space
            let spatialButton = SpatialButton(
                title: "Immersive Button",
                position: SpatialPosition(x: 0, y: 0, z: -1)
            )
            
            content.add(spatialButton)
        }
        .onAppear {
            setupImmersiveSpace()
        }
    }
    
    private func setupImmersiveSpace() {
        let spaceConfig = ImmersiveSpaceConfiguration()
        spaceConfig.enableFullImmersive = true
        spaceConfig.enableSpatialAudio = true
        spaceConfig.enableEnvironmentalEffects = true
        
        immersiveManager.configure(spaceConfig)
    }
}
```

## Understanding Spatial Computing

### Key Concepts

1. **Spatial Context**: Everything exists in 3D space
2. **Depth Perception**: Understanding distance and depth
3. **Spatial Interaction**: How users interact with 3D elements
4. **Immersive Experiences**: Full or mixed reality environments
5. **Spatial Audio**: 3D audio that responds to position

### Spatial Coordinate System

VisionOS uses a right-handed coordinate system:
- **X-axis**: Left to right
- **Y-axis**: Down to up
- **Z-axis**: Back to front (negative is closer)

### Best Practices

1. **Performance**: Optimize for 60fps+ performance
2. **Accessibility**: Ensure all features are accessible
3. **User Comfort**: Consider user comfort and safety
4. **Spatial Audio**: Use spatial audio for immersion
5. **Haptic Feedback**: Provide tactile feedback

## Next Steps

### Advanced Features

1. **Spatial Gestures**: Implement custom gesture recognition
2. **Eye Tracking**: Add gaze-based interactions
3. **Voice Commands**: Implement voice control
4. **Spatial Physics**: Add realistic physics simulation
5. **Multi-User**: Enable collaborative experiences

### Learning Resources

1. **Documentation**: Read the comprehensive API documentation
2. **Examples**: Study the provided example projects
3. **Spatial UI Guide**: Learn about spatial interface design
4. **Performance Guide**: Optimize your app's performance
5. **Best Practices**: Follow spatial computing best practices

### Community

1. **GitHub Issues**: Report bugs and request features
2. **Discussions**: Join community discussions
3. **Contributing**: Contribute to the framework
4. **Examples**: Share your own examples

## Troubleshooting

### Common Issues

1. **Build Errors**:
   - Ensure Xcode 15.0+ is installed
   - Check VisionOS SDK is properly installed
   - Verify Swift 5.9+ is being used

2. **Runtime Errors**:
   - Check framework initialization
   - Verify spatial permissions
   - Ensure proper configuration

3. **Performance Issues**:
   - Monitor frame rate
   - Optimize component count
   - Use performance monitoring tools

4. **Spatial Issues**:
   - Check spatial positioning
   - Verify depth management
   - Ensure proper scaling

### Debug Tips

1. **Use Console Logging**:
   ```swift
   print("Framework status: \(frameworkManager.status)")
   print("Performance metrics: \(frameworkManager.performanceMetrics)")
   ```

2. **Enable Debug Mode**:
   ```swift
   let config = VisionOSUIFrameworkConfiguration()
   config.enableDebugMode = true
   ```

3. **Monitor Performance**:
   ```swift
   frameworkManager.startPerformanceMonitoring { metrics in
       print("FPS: \(metrics.framesPerSecond)")
       print("Memory: \(metrics.memoryUsage) MB")
   }
   ```

### Getting Help

1. **Check Documentation**: Review the comprehensive documentation
2. **Study Examples**: Look at the provided example projects
3. **GitHub Issues**: Search existing issues or create new ones
4. **Community**: Join the community discussions

This Getting Started Guide provides everything you need to begin creating amazing spatial computing experiences with the VisionOS UI Framework!
