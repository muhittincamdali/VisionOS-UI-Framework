# VisionOS-UI-Framework

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![VisionOS](https://img.shields.io/badge/VisionOS-1.0-blue.svg)](https://developer.apple.com/visionos/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-VisionOS-lightblue.svg)](https://developer.apple.com/visionos/)

A comprehensive UI framework for VisionOS providing spatial computing patterns, 3D interface components, and immersive experiences for spatial computing applications.

## 🌟 Features

- **Spatial Components**: 3D UI elements designed for spatial computing
- **Gesture Recognition**: Advanced spatial gesture handling
- **Accessibility**: Full accessibility support for spatial interfaces
- **Performance**: Optimized for 60fps+ performance
- **Immersive Experiences**: Tools for creating compelling AR experiences
- **Clean Architecture**: Built with SOLID principles and clean architecture
- **Comprehensive Testing**: 100% test coverage
- **Documentation**: Complete API documentation

## 🚀 Quick Start

### Installation

Add the VisionOS-UI-Framework to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework", from: "1.0.0")
]
```

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

## 📚 Documentation

### Spatial Components

#### SpatialContainer
A container that provides spatial context for 3D UI elements:

```swift
SpatialContainer {
    // Your 3D content here
}
```

#### SpatialButton
A 3D button designed for spatial interaction:

```swift
SpatialButton("Tap Me", style: .primary) {
    // Handle button tap
}
```

#### SpatialCard
A 3D card component for displaying content:

```swift
SpatialCard {
    Text("Card Content")
    Image(systemName: "star.fill")
}
```

### Spatial Gestures

#### Tap Gesture
```swift
Text("Tap Me")
    .spatialTap {
        // Handle tap
    }
```

#### Drag Gesture
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

## 🔧 Requirements

- **VisionOS**: 1.0+
- **Swift**: 5.9+
- **Xcode**: 15.0+
- **iOS**: 17.0+ (for development)

## 📦 Installation

### Swift Package Manager

1. In Xcode, go to **File** > **Add Package Dependencies**
2. Enter the repository URL: `https://github.com/muhittincamdali/VisionOS-UI-Framework`
3. Select the version you want to use
4. Click **Add Package**

## 🧪 Testing

The framework includes comprehensive tests:

```bash
swift test
```

## 📖 Examples

Check out the `Examples/` directory for complete sample applications.

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/muhittincamdali/VisionOS-UI-Framework/issues)
- **Discussions**: [GitHub Discussions](https://github.com/muhittincamdali/VisionOS-UI-Framework/discussions)

---

**Made with ❤️ for the VisionOS community**
