# 🚀 Getting Started with VisionOSUI

Build spatial experiences for Apple Vision Pro in minutes with VisionOSUI Framework.

## Prerequisites

| Requirement | Version |
|-------------|---------|
| visionOS | 1.0+ |
| Xcode | 15.0+ |
| Swift | 5.9+ |
| macOS | 14.0+ (Sonoma) |
| Apple Vision Pro | Required for device testing |

> **Note:** You can use the visionOS Simulator for initial development, but real device testing is recommended for gesture and eye-tracking features.

## Installation

### Swift Package Manager (Recommended)

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
]
```

Or in Xcode:
1. Go to `File > Add Package Dependencies...`
2. Enter: `https://github.com/muhittincamdali/VisionOS-UI-Framework.git`
3. Select version `1.0.0` or later

## Your First Spatial App

### 1. Create a New visionOS Project

In Xcode, create a new project:
- Platform: **visionOS**
- Application Type: **App**
- Initial Scene: **Window**

### 2. Import VisionOSUI

```swift
import SwiftUI
import VisionOSUI
```

### 3. Create Your First Spatial View

```swift
import SwiftUI
import VisionOSUI

struct ContentView: View {
    var body: some View {
        SpatialCard(style: .glass) {
            VStack(spacing: 24) {
                Image(systemName: "visionpro")
                    .font(.system(size: 80))
                    .foregroundStyle(.blue)
                
                Text("Welcome to Spatial Computing")
                    .font(.extraLargeTitle)
                
                Text("Your first VisionOSUI app!")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                SpatialButton("Get Started", style: .primary) {
                    print("Button tapped!")
                }
            }
            .padding(32)
        }
    }
}
```

### 4. Run in Simulator

Press `Cmd + R` to build and run. You should see a beautiful glass-morphic card floating in space!

## Adding Gestures

Make your UI interactive with spatial gestures:

```swift
struct InteractiveView: View {
    @State private var scale: Double = 1.0
    @State private var isHovering = false
    
    var body: some View {
        SpatialCard(style: isHovering ? .elevated : .default) {
            Image(systemName: "cube.fill")
                .font(.system(size: 100))
                .scaleEffect(scale)
        }
        .spatialPinch { value in
            scale = value.scale
        }
        .spatialHover(
            onEntered: { isHovering = true },
            onExited: { isHovering = false }
        )
    }
}
```

## Next Steps

| Guide | What You'll Learn |
|-------|------------------|
| [Spatial UI Guide](SpatialUIGuide.md) | All UI components |
| [3D Interactions](3DInteractionsGuide.md) | Gestures and hand tracking |
| [Immersive Experiences](ImmersiveExperiencesGuide.md) | Full immersion modes |
| [Accessibility](AccessibilityGuide.md) | VoiceOver and accessibility |
| [Performance](PerformanceGuide.md) | Optimization tips |

## Example Projects

Check out the [Examples](../Examples/) folder for complete sample projects:

- **BasicExample** - Simple spatial card demo
- **3DInteractionExamples** - Hand gesture showcase
- **ImmersiveExperienceExamples** - Full immersion demo
- **SpatialUIExamples** - All components showcase
- **SpatialAudioExamples** - 3D audio integration

## Need Help?

- 📖 [Full Documentation](README.md)
- 🐛 [Report Issues](https://github.com/muhittincamdali/VisionOS-UI-Framework/issues)
- 💬 [Discussions](https://github.com/muhittincamdali/VisionOS-UI-Framework/discussions)

---

Happy spatial coding! 🥽✨
