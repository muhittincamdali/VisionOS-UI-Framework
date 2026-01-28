# VisionOS UI Framework

<p align="center">
  <img src="Assets/banner.png" alt="VisionOS UI Framework" width="800">
</p>

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-5.9+-F05138?style=flat&logo=swift&logoColor=white" alt="Swift"></a>
  <a href="https://developer.apple.com/visionos/"><img src="https://img.shields.io/badge/visionOS-1.0+-007AFF?style=flat&logo=apple&logoColor=white" alt="visionOS"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License"></a>
</p>

<p align="center">
  <b>Build spatial experiences for Apple Vision Pro with SwiftUI and RealityKit.</b>
</p>

---

## Features

- **Spatial UI Components** — Windows, volumes, and immersive spaces
- **3D Content** — RealityKit integration for 3D models
- **Eye & Hand Tracking** — Gesture recognition in spatial computing
- **Immersive Experiences** — Full, mixed, and progressive immersion
- **Ornaments** — Floating UI elements attached to windows

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
]
```

## Quick Start

### Basic Window

```swift
import SwiftUI

@main
struct MyVisionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.automatic)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, Vision Pro!")
                .font(.extraLargeTitle)
            
            Model3D(named: "Globe") { model in
                model
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 300, height: 300)
        }
        .padding()
    }
}
```

### Volume (3D Space)

```swift
@main
struct VolumeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        WindowGroup(id: "volume") {
            VolumeContent()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)
    }
}

struct VolumeContent: View {
    var body: some View {
        RealityView { content in
            let sphere = MeshResource.generateSphere(radius: 0.1)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            let entity = ModelEntity(mesh: sphere, materials: [material])
            content.add(entity)
        }
    }
}
```

### Immersive Space

```swift
@main
struct ImmersiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        ImmersiveSpace(id: "immersive") {
            ImmersiveView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed, .full)
    }
}

struct ContentView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @State private var isImmersive = false
    
    var body: some View {
        Button(isImmersive ? "Exit" : "Enter Immersive") {
            Task {
                if isImmersive {
                    await dismissImmersiveSpace()
                } else {
                    await openImmersiveSpace(id: "immersive")
                }
                isImmersive.toggle()
            }
        }
    }
}

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add 3D content to the immersive space
            let floor = ModelEntity(
                mesh: .generatePlane(width: 10, depth: 10),
                materials: [SimpleMaterial(color: .gray, isMetallic: false)]
            )
            floor.position = [0, 0, 0]
            content.add(floor)
        }
    }
}
```

### Ornaments

```swift
struct WindowWithOrnament: View {
    var body: some View {
        NavigationStack {
            ContentView()
        }
        .ornament(attachmentAnchor: .scene(.bottom)) {
            HStack(spacing: 20) {
                Button(action: {}) {
                    Label("Play", systemImage: "play.fill")
                }
                Button(action: {}) {
                    Label("Pause", systemImage: "pause.fill")
                }
                Button(action: {}) {
                    Label("Stop", systemImage: "stop.fill")
                }
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}
```

### Hand Tracking Gestures

```swift
struct GestureView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    
    var body: some View {
        Model3D(named: "Object")
            .scaleEffect(scale)
            .rotation3DEffect(rotation, axis: (x: 0, y: 1, z: 0))
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        scale = value.magnification
                    }
            )
            .gesture(
                RotateGesture3D()
                    .onChanged { value in
                        rotation = value.rotation
                    }
            )
    }
}
```

### Hover Effects

```swift
struct HoverCard: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .font(.largeTitle)
            Text("Hover Me")
        }
        .padding(30)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .hoverEffect(.highlight)
    }
}
```

## Spatial Design Guidelines

### Depth & Layering
```swift
// Use z-offset for depth
VStack { ... }
    .offset(z: 50) // Points toward user

// Glass material for floating panels
.glassBackgroundEffect()
```

### Sizing
```swift
// Use meters for volumetric content
.defaultSize(width: 1.0, height: 1.0, depth: 1.0, in: .meters)

// Use points for windows
.defaultSize(width: 1200, height: 800)
```

### Eye Comfort
```swift
// Comfortable viewing distance: 1-2 meters
// Avoid rapid movements
// Use subtle animations
withAnimation(.easeInOut(duration: 0.5)) { ... }
```

## Project Structure

```
VisionOS-UI-Framework/
├── Sources/
│   ├── Scenes/
│   │   ├── WindowScene.swift
│   │   ├── VolumeScene.swift
│   │   └── ImmersiveScene.swift
│   ├── Components/
│   │   ├── SpatialButton.swift
│   │   └── Ornaments.swift
│   ├── RealityKit/
│   │   └── EntityHelpers.swift
│   └── Utils/
├── Examples/
└── Tests/
```

## Requirements

- visionOS 1.0+
- Xcode 15.0+
- Swift 5.9+

## Documentation

- [Getting Started](Documentation/GettingStarted.md)
- [Windows & Volumes](Documentation/WindowsVolumes.md)
- [Immersive Spaces](Documentation/ImmersiveSpaces.md)
- [RealityKit Integration](Documentation/RealityKit.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License. See [LICENSE](LICENSE).

## Author

**Muhittin Camdali** — [@muhittincamdali](https://github.com/muhittincamdali)

---

<p align="center">
  <sub>Building the future of spatial computing ❤️</sub>
</p>
