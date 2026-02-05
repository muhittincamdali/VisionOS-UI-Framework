<p align="center">
  <img src="https://img.shields.io/badge/visionOS-2.0+-purple?style=for-the-badge&logo=apple" alt="visionOS"/>
  <img src="https://img.shields.io/badge/Swift-6.0-orange?style=for-the-badge&logo=swift" alt="Swift"/>
  <img src="https://img.shields.io/badge/RealityKit-3.0-blue?style=for-the-badge" alt="RealityKit"/>
  <img src="https://img.shields.io/github/license/muhittincamdali/VisionOS-UI-Framework?style=for-the-badge" alt="License"/>
</p>

<h1 align="center">🥽 VisionOS UI Framework</h1>

<p align="center">
  <strong>The World's Most Comprehensive Native VisionOS UI Component Library</strong>
</p>

<p align="center">
  Build stunning spatial experiences for Apple Vision Pro with 50+ ready-to-use components, SwiftUI-style syntax, and zero boilerplate.
</p>

<p align="center">
  <a href="#-features">Features</a> •
  <a href="#-installation">Installation</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-components">Components</a> •
  <a href="#-documentation">Documentation</a>
</p>

---

## 🌟 Why VisionOS UI Framework?

**The Problem**: Building UI for Apple Vision Pro is complex. You need to understand RealityKit, ARKit, SwiftUI 3D extensions, hand tracking, eye tracking, and spatial computing paradigms.

**The Solution**: VisionOS UI Framework provides familiar SwiftUI-style components that abstract all the complexity. Write declarative code, get immersive experiences.

```swift
// Before: 50+ lines of RealityKit boilerplate
let anchor = AnchorEntity(.plane(.horizontal, classification: .table))
let modelEntity = try! Entity.load(named: "model")
// ... lots more setup code ...

// After: 3 lines of declarative code
SpatialCarousel(items: products) { product in
    ProductCard(product: product)
}
.radius(2.0)
.autoRotate(speed: 0.5)
```

---

## ✨ Features

### 🎯 50+ Spatial Components

| Category | Components |
|----------|------------|
| **3D Components** | SpatialCarousel, Model3DView, VolumetricText, TurntableView, FloatingObject, OrbitView |
| **Spatial Menus** | SpatialMenu, RadialMenu, OrbitalMenu, ContextMenu3D, QuickActionsMenu |
| **3D Charts** | BarChart3D, PieChart3D, LineChart3D, ScatterPlot3D |
| **Hand Tracking** | HandTrackingView, PalmAnchoredMenu, FingerTipButton, PinchSlider, GestureRecognition |
| **Eye Tracking** | EyeTrackingView, GazeButton, AttentionAwareView, GazeScrollView, FocusRing |
| **Ornaments** | ToolbarOrnament, TabBarOrnament, InfoPanelOrnament, MediaControlsOrnament, BreadcrumbOrnament |
| **Window Management** | ManagedWindow, SpatialSplitView, PictureInPicture, WindowSnapping |
| **Immersive Spaces** | ImmersiveContainer, SpatialEnvironment, PortalView, Anchor3D, SharedSpaceCoordinator |
| **AR Annotations** | Annotation3D, ObjectLabel, InfoHotspot, MeasurementAnnotation, StepByStepGuide |
| **Custom Materials** | GlassMaterial, HolographicEffect, NeonGlow, AnimatedGradient, FrostedGlass |
| **Volume Views** | VolumeContainer, VolumetricText, TurntableView, FloatingObject |

### 🚀 Key Highlights

- **SwiftUI-Style API** - Familiar declarative syntax
- **Zero Boilerplate** - Focus on your app, not plumbing
- **Full Accessibility** - VoiceOver, pointer, switch control support
- **Performance Optimized** - 60fps animations guaranteed
- **Xcode Previews** - See your spatial UI in real-time
- **Complete Documentation** - DocC documentation included
- **100% Swift** - No Objective-C, no bridging headers

---

## 📦 Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
]
```

### CocoaPods

```ruby
pod 'VisionOSUIFramework', '~> 1.0'
```

### Requirements

| Requirement | Version |
|-------------|---------|
| visionOS | 2.0+ |
| Xcode | 16.0+ |
| Swift | 6.0+ |

---

## 🚀 Quick Start

### 1. Import the Framework

```swift
import VisionOSUIFramework
```

### 2. Create Your First Spatial View

```swift
struct ContentView: View {
    var body: some View {
        VolumeContainer(size: .medium) {
            SpatialCarousel(items: products) { product in
                ProductCard(product: product)
                    .glassMaterial()
            }
            .radius(1.5)
            .autoRotate(speed: 0.3)
        }
        .ornament(edge: .bottom) {
            ToolbarOrnament(items: [
                ToolbarItem(icon: "house.fill", title: "Home") { },
                ToolbarItem(icon: "gear", title: "Settings") { }
            ])
        }
    }
}
```

---

## 🧩 Components

### 🎠 Spatial Carousel

A 3D carousel for showcasing content in immersive space.

```swift
SpatialCarousel(items: photos) { photo in
    AsyncImage(url: photo.url)
        .frame(width: 300, height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 16))
}
.radius(2.0)              // Carousel radius in meters
.autoRotate(speed: 0.3)   // Auto-rotation speed
.itemSpacing(.degrees(45)) // Angular spacing between items
.haptics(true)             // Enable haptic feedback
```

### 📊 3D Charts

Stunning 3D data visualizations.

```swift
// 3D Bar Chart
BarChart3D(data: salesData, value: \.revenue, label: \.month)
    .depth(0.3)
    .animateOnAppear(true)
    .colorScheme(.vibrant)

// 3D Pie Chart
PieChart3D(data: marketShare, value: \.percentage, label: \.company)
    .depth(0.2)
    .explode(true)
    
// 3D Scatter Plot
ScatterPlot3D(data: points, x: \.x, y: \.y, z: \.z, size: \.importance)
```

### 👋 Hand Tracking UI

Build hand-gesture-driven interfaces.

```swift
HandTrackingView {
    PalmAnchoredMenu {
        SpatialMenuItem(icon: "house.fill", title: "Home") { }
        SpatialMenuItem(icon: "gear", title: "Settings") { }
    }
    .hand(.left)
    .autoHide(true, delay: 3.0)
}
.handedness(.both)
.sensitivity(.high)
```

### 👁️ Eye Tracking UI

Gaze-based interactions made simple.

```swift
EyeTrackingView {
    GazeButton("Select Me") {
        performAction()
    }
    .dwellDuration(0.5)
    .showProgress(true)
}
.gazeIndicator(.spotlight)
.dwellSelection(true)
```

### 🏷️ Ornaments

Floating UI attached to window edges.

```swift
ContentView()
    .ornament(edge: .bottom, alignment: .center) {
        TabBarOrnament(selection: $tab, tabs: [
            TabItem(icon: "house.fill", title: "Home", tag: 0),
            TabItem(icon: "magnifyingglass", title: "Search", tag: 1),
            TabItem(icon: "person.fill", title: "Profile", tag: 2)
        ])
        .style(.pills)
    }
```

### 🪟 Window Management

Multi-window layouts and management.

```swift
WindowManager {
    ManagedWindow("Main") {
        MainContentView()
    }
    .defaultSize(width: 800, height: 600)
    .snapBehavior(.edges)
    .resizable(true)
}
.snapping(true)
.minimizedDock(true)
```

### 🌌 Immersive Spaces

Full and mixed reality experiences.

```swift
ImmersiveContainer(style: .mixed) {
    SpatialEnvironment("forest")
        .rotation(.degrees(45))
        .animated(true, speed: 0.05)
    
    Anchor3D(.floor) {
        Model3DView("tree")
            .scale(2.0)
    }
}
.passthrough(.dimmed(0.5))
.showBoundary(true)
```

### 📍 AR Annotations

Place labels and information in 3D space.

```swift
AnnotationView {
    Annotation3D(at: position) {
        Label("Product Name", systemImage: "tag")
    }
    .style(.callout)
    .connector(.curved)
    .billboarding(true)
    .fadeWithDistance(true)
    
    InfoHotspot {
        Text("Tap for details")
    }
    .icon("info.circle.fill")
    .pulseAnimation(true)
}
.showConnectors(true)
.clusterOverlapping(true)
```

### 🎨 Custom Materials

Stunning visual effects.

```swift
// Glass Material
view.glassMaterial(tint: .blue, opacity: 0.8)

// Holographic Effect
view.holographic(colors: [.cyan, .purple, .pink])

// Neon Glow
view.neonGlow(color: .cyan, radius: 20, animated: true)

// Frosted Glass
view.frostedGlass(intensity: 0.5, cornerRadius: 20)
```

---

## 🎯 Use Cases

### Product Showcase
```swift
VolumeContainer(size: .large) {
    TurntableView {
        Model3DView("product")
            .rotatable()
            .zoomable()
    }
    .speed(0.3)
    .pauseOnInteraction(true)
}
.ornament(edge: .bottom) {
    MediaControlsOrnament(...)
}
```

### Data Dashboard
```swift
SpatialSplitView {
    BarChart3D(data: sales, ...)
} secondary: {
    PieChart3D(data: breakdown, ...)
}
.splitRatio(0.6)
.orientation(.horizontal)
```

### AR Training
```swift
StepByStepGuide(steps: trainingSteps, currentStep: $step)
    .showProgress(true)
    .autoAdvance(false)
```

---

## 📖 Documentation

Full DocC documentation is available:

```bash
# Generate documentation
swift package generate-documentation

# Open in Xcode
open .build/documentation/VisionOSUIFramework/index.html
```

---

## 🏗️ Architecture

```
VisionOSUIFramework/
├── Sources/
│   └── VisionUI/
│       ├── Components/
│       │   ├── SpatialCarousel.swift
│       │   ├── SpatialMenu.swift
│       │   ├── SpatialCharts.swift
│       │   ├── HandTrackingUI.swift
│       │   ├── EyeTrackingUI.swift
│       │   ├── Ornaments.swift
│       │   ├── WindowManagement.swift
│       │   ├── ImmersiveSpaces.swift
│       │   ├── ARAnnotations.swift
│       │   ├── CustomMaterials.swift
│       │   └── VolumeViews.swift
│       ├── Gestures/
│       ├── Spatial/
│       ├── Accessibility/
│       └── Utilities/
├── Tests/
├── Examples/
└── Documentation/
```

---

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Apple's visionOS team for the incredible platform
- The Swift community for continuous inspiration
- All contributors who help make this project better

---

<p align="center">
  <strong>Built with ❤️ for the spatial computing future</strong>
</p>

<p align="center">
  <a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/stargazers">⭐ Star this repo</a> •
  <a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/issues">🐛 Report Bug</a> •
  <a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/issues">💡 Request Feature</a>
</p>
