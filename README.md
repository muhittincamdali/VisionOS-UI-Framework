<div align="center">

# 🥽 VisionOS-UI-Framework

**Spatial UI framework for visionOS and Apple Vision Pro development**

[![Swift](https://img.shields.io/badge/Swift-5.9+-F05138?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![visionOS](https://img.shields.io/badge/visionOS-1.0+-007AFF?style=for-the-badge&logo=apple&logoColor=white)](https://developer.apple.com/visionos/)
[![SPM](https://img.shields.io/badge/SPM-Compatible-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

---

## ✨ Features

- 🌌 **Spatial Design** — Depth-aware UI components
- 🪟 **Window Types** — Plain, volumetric, immersive
- 👆 **Gestures** — Eye tracking, hand gestures
- 🎨 **Glass Material** — Native visionOS materials
- 🔊 **Spatial Audio** — 3D audio positioning

---

## 🚀 Quick Start

```swift
import VisionOSUIFramework

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .glassBackgroundEffect()
        }
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: "immersive") {
            ImmersiveView()
        }
    }
}
```

---

## 📄 License

MIT • [@muhittincamdali](https://github.com/muhittincamdali)
