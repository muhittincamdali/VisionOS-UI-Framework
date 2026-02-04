<p align="center">
  <img src="Assets/logo.png" alt="VisionOS UI Framework" width="200"/>
</p>

<h1 align="center">VisionOS UI Framework</h1>

<p align="center">
  <strong>🥽 Build immersive spatial experiences for Apple Vision Pro with SwiftUI-style syntax</strong>
</p>

<p align="center">
  <a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml">
    <img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="CI Status"/>
  </a>
  <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift 6.0"/>
  <img src="https://img.shields.io/badge/visionOS-2.0+-purple.svg" alt="visionOS 2.0+"/>
  <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License"/>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#components">Components</a> •
  <a href="#documentation">Documentation</a>
</p>

---

## Why VisionOS UI Framework?

Building spatial UI for Apple Vision Pro requires understanding RealityKit, ARKit, and new visionOS paradigms. **VisionOS UI Framework** abstracts the complexity and provides familiar SwiftUI-style components for spatial computing.

```swift
// Before: Complex RealityKit setup
let anchor = AnchorEntity(.plane(.horizontal, classification: .table))
let modelEntity = try! Entity.load(named: "model")
anchor.addChild(modelEntity)
arView.scene.addAnchor(anchor)

// After: Simple declarative syntax
SpatialView {
    Model3D("model")
        .placement(.table)
        .gesture(TapGesture().onTap { print("Tapped!") })
}
```

## Features

| Feature | Description |
|---------|-------------|
| 🎯 **SwiftUI-Style API** | Familiar declarative syntax for spatial UI |
| 🌍 **3D Components** | Model3D, SpatialText, VolumetricView, and more |
| 👋 **Gesture System** | Eye tracking, hand gestures, voice commands |
| 🎨 **Materials & Shaders** | PBR materials, custom shaders, glass effects |
| 🔊 **Spatial Audio** | 3D positional audio with HRTF |
| 🌐 **Portal & Immersive Spaces** | Full immersion and mixed reality |
| ♿ **Accessible** | VoiceOver, pointer, and switch control support |
| 📖 **Well Documented** | Complete DocC documentation |

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
]
```

### Requirements

| Platform | Minimum Version |
|----------|-----------------|
| visionOS | 2.0+ |
| Xcode | 16.0+ |
| Swift | 6.0+ |

## Quick Start

### 1. Import the Framework

```swift
import VisionOSUIFramework
```

### 2. Create a Spatial View

```swift
struct ContentView: View {
    var body: some View {
        SpatialView {
            // 3D Model
            Model3D("robot")
                .scale(0.5)
                .position(x: 0, y: 1, z: -2)
            
            // Floating text
            SpatialText("Hello, Vision Pro!")
                .font(.spatial(.title))
                .position(y: 2)
            
            // Interactive button
            SpatialButton("Tap Me") {
                print("Spatial button tapped!")
            }
            .glassBackground()
        }
    }
}
```

### 3. Add Gestures

```swift
Model3D("cube")
    .gesture(
        SpatialTapGesture()
            .onTap { location in
                print("Tapped at \(location)")
            }
    )
    .gesture(
        SpatialDragGesture()
            .onDrag { value in
                // Move the model
            }
    )
```

## Components

### 3D Objects

#### Model3D

Load and display 3D models:

```swift
Model3D("character") // From bundle
Model3D(url: modelURL) // From URL
Model3D(entity: customEntity) // Custom entity
```

#### SpatialShape

Built-in 3D primitives:

```swift
SpatialShape(.sphere(radius: 0.5))
SpatialShape(.box(width: 1, height: 1, depth: 1))
SpatialShape(.cylinder(radius: 0.3, height: 1))
SpatialShape(.capsule(radius: 0.2, height: 0.8))
SpatialShape(.cone(radius: 0.4, height: 1))
```

#### SpatialText

3D floating text:

```swift
SpatialText("Welcome")
    .font(.spatial(.largeTitle))
    .foregroundStyle(.gradient)
    .depth(0.1) // Extrusion depth
```

### Containers

#### VolumetricView

Create bounded 3D volumes:

```swift
VolumetricView(size: Size3D(width: 1, height: 1, depth: 1)) {
    Model3D("scene")
}
.ornament(position: .top) {
    Text("Controls")
}
```

#### ImmersiveSpace

Full immersive experiences:

```swift
ImmersiveSpace(id: "game") {
    GameEnvironment()
}
.immersionStyle(.full)
```

#### Portal

Windows into other worlds:

```swift
Portal(to: "beach-scene") {
    RoundedRectangle(cornerRadius: 20)
        .frame(width: 300, height: 400)
}
```

### Materials

#### Glass Material

Native visionOS glass effect:

```swift
SpatialShape(.box)
    .material(.glass)
    .glassThickness(.thin)
```

#### PBR Material

Physically-based rendering:

```swift
Model3D("object")
    .material(
        .pbr(
            baseColor: .blue,
            metallic: 0.8,
            roughness: 0.2
        )
    )
```

#### Custom Shaders

Metal shader support:

```swift
SpatialShape(.sphere)
    .shader(.custom("HologramShader"))
```

### Gestures

#### Tap Gesture

```swift
.gesture(SpatialTapGesture().onTap { _ in })
```

#### Drag Gesture

```swift
.gesture(SpatialDragGesture().onDrag { value in })
```

#### Rotation Gesture

```swift
.gesture(SpatialRotationGesture().onRotate { angle in })
```

#### Pinch Gesture

```swift
.gesture(SpatialPinchGesture().onPinch { scale in })
```

### Spatial Audio

```swift
Model3D("speaker")
    .spatialAudio(
        source: "music.mp3",
        radius: 5,
        falloff: .logarithmic
    )
```

### Animations

```swift
Model3D("character")
    .spatialAnimation(.rotate, axis: .y, duration: 2)
    .spatialAnimation(.float, amplitude: 0.1)
    .spatialAnimation(.pulse, scale: 1.1)
```

## Advanced Usage

### Hand Tracking

```swift
HandTrackingView { hands in
    if let rightHand = hands.right {
        Model3D("pointer")
            .position(rightHand.indexTip)
    }
}
```

### Eye Tracking

```swift
EyeTrackingView { gaze in
    Cursor()
        .position(gaze.point)
}
```

### Spatial Anchors

```swift
SpatialAnchor(.plane(.horizontal)) { anchor in
    Model3D("furniture")
        .position(anchor.position)
}
```

### SharePlay Integration

```swift
SpatialGroupActivity("chess-game") { session in
    ChessBoard()
        .synchronized(with: session)
}
```

## Best Practices

### Performance

```swift
// ✅ Good: Preload models
Model3D("heavy-model")
    .preload()

// ✅ Good: Use LOD
Model3D("character")
    .levelOfDetail([
        .high: "character_high",
        .medium: "character_medium",
        .low: "character_low"
    ])
```

### Accessibility

```swift
Model3D("button")
    .accessibilityLabel("Play button")
    .accessibilityHint("Double tap to play")
    .accessibilityAction(.default) {
        play()
    }
```

### Comfort

```swift
// Respect user's comfort settings
SpatialView {
    content
}
.comfortSettings(.userPreferred)
.motionSickness(.reduced)
```

## Examples

Check out the [Examples](Examples/) folder:

- **HelloVision** - Getting started
- **SpatialGallery** - 3D image gallery
- **VirtualShowroom** - Product showcase
- **ImmersiveGame** - Full immersive experience

## API Reference

### SpatialView

```swift
public struct SpatialView<Content: SpatialContent>: View {
    public init(@SpatialBuilder content: () -> Content)
}
```

### Model3D

```swift
public struct Model3D: SpatialContent {
    public init(_ name: String)
    public init(url: URL)
    public init(entity: Entity)
    
    public func scale(_ scale: Float) -> Model3D
    public func position(_ position: SIMD3<Float>) -> Model3D
    public func rotation(_ rotation: simd_quatf) -> Model3D
    public func material(_ material: SpatialMaterial) -> Model3D
}
```

## Migration from RealityKit

```swift
// RealityKit
let entity = ModelEntity(mesh: .generateBox(size: 0.5))
entity.model?.materials = [SimpleMaterial(color: .blue, isMetallic: true)]

// VisionOS UI Framework
SpatialShape(.box(size: 0.5))
    .material(.pbr(baseColor: .blue, metallic: 1.0))
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) file.

---

<p align="center">
  <sub>Built with ❤️ for the spatial computing future</sub>
</p>

---

## 📈 Star History

<a href="https://star-history.com/#muhittincamdali/VisionOS-UI-Framework&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/VisionOS-UI-Framework&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=muhittincamdali/VisionOS-UI-Framework&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=muhittincamdali/VisionOS-UI-Framework&type=Date" />
 </picture>
</a>
