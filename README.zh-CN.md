<!-- i18n-source: README.md@608280ce28466a834e3e8a4214b5f85aae8f74ea status=reviewed -->
<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-zh-CN-light.svg" alt="VisionOS UI Framework: 适用于 visionOS 应用的空间布局、轮播、沉浸式空间和受限操控。"></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="CI 状态"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="最新版本: v1.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="支持的平台: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="语言版本: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="许可证: MIT"></picture></a>
</p>

<p align="center">
<a href="#快速开始"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-zh-CN-light.svg" alt="开始使用"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-zh-CN-light.svg" alt="文档"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-zh-CN-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-zh-CN-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-zh-CN-light.svg" alt="示例"></picture></a>
</p>

> 本文是英文 README 的译文。如两者内容不一致，以英文版为准。

<!-- brand:end -->
这是一个面向 visionOS 应用的 Swift 包：它用五种布局（弧形、环形、网格、球面、螺旋）把 SwiftUI 视图和 RealityKit 实体摆放到三维空间中，把一圈视图变成轮播，打开和关闭沉浸式空间时不会出现手动维护标志位带来的竞态，并让用户在你设定的范围内移动、缩放和旋转对象。它适合不想自己编写几何计算和状态处理、却需要这些空间构件的开发者。同一份代码也能在 iOS 和 macOS 上运行，布局会按正面视角绘制，并且这个包没有任何依赖。

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="示例应用在 Apple Vision Pro 模拟器上的效果：五张以行星命名的玻璃卡片排成一条朝观看者弯曲的弧线，外侧的卡片更近，并朝向中间"></p>

## 亮点

- **五种空间布局** — 弧形、环形、网格、球面和螺旋会为每个元素返回以米为单位的位置和朝向。SwiftUI 视图使用 `SpatialLayoutView`，RealityKit 实体使用 `arrangeChildren(using:)`。
- **没有竞态的沉浸式空间** — `ImmersiveSpaceCoordinator` 在切换过程中会拒绝第二个请求，打开新空间前先关闭当前空间，并且在用户用 Digital Crown 关闭空间时跟随系统状态。
- **有限制的操控** — `ManipulationState` 让被拖动、捏合或旋转的对象保持在指定的盒形范围和缩放区间内，可选择保持直立，支持吸附，并忽略异常的手势数值。
- **按平台调整尺寸的组件** — `SpatialCard`、在 visionOS 上变为 ornament 的工具栏，以及按 Apple 指南设定尺寸的点击目标（visionOS 为 60 pt，iOS 为 44，macOS 为 28）。
- **不受信任的输入也是安全的** — 数量上限为 4096 项，长度上限为 10 km，NaN 或无穷大的参数会回退到文档中说明的默认值，因此从文件读取的数值不会耗尽内存，也不会产生无限远的位置。
- **在三个平台上测试** — 97 个 Swift Testing 测试在 macOS 和 iPhone 模拟器上运行；除像素测试外的 87 个也在 visionOS 模拟器上运行。

### 包含内容

| 领域       | API                                                                                                                              |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 布局       | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI    | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| 沉浸式空间 | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| 操控       | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| 组件       | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## 快速开始

**1. 添加软件包**

在 Xcode 中选择 **File › Add Package Dependencies…**，然后输入仓库地址：

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

把它粘贴到窗口右上角的搜索框中。将 **Dependency Rule** 保持为从 `2.0.0` 开始的 **Up to Next Major Version**，然后点击 **Add Package**。在下一个窗口中，在 **VisionUI** 旁边选择你的应用 target，再次点击 **Add Package**。

**2. 导入模块**

```swift
import VisionUI
```

把这一行放在你使用该包的 Swift 文件顶部，位于 `import SwiftUI` 之后。

**3. 开始使用**

在新建的 visionOS 应用中（**File › New › Project… › visionOS › App**），将 `ContentView.swift` 的全部内容替换为：

```swift
import SwiftUI
import VisionUI

struct ContentView: View {
    let planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter"]

    var body: some View {
        SpatialLayoutView(.arc(radius: 0.6, spacing: 0.17), planets, id: \.self) { planet in
            SpatialCard {
                Text(planet)
                    .font(.title)
            }
        }
    }
}
```

选择 **Apple Vision Pro** 模拟器，然后按 **Run**（⌘R）。五张卡片会像上图一样朝你弯曲：中间的一张位于窗口平面内，外侧的更靠近你并朝向弧线的圆心，整条弧线位于窗口前方 0.6 m 处。把半径改成 `0.3` 再运行一次，曲线会更紧。同样的代码也能在 iPhone 或 Mac 上运行，弧线会按正面视角绘制。

## 安装

### Swift Package Manager

在 Xcode 中选择 **File › Add Package Dependencies…**，然后输入仓库地址：

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

或者将其添加到 `Package.swift` 的 `dependencies` 中：

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "2.0.0")
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "VisionUI", package: "VisionOS-UI-Framework")
    ])
]
```

2.0.0 版本（2026 年 10 月）是一个全新的包，API 也是全新的。此前的 1.0.0 版本（2026 年 2 月）声明了一个并不存在的平台版本（`.visionOS(.v1_0)`），因此 Swift Package Manager 无法解析它，而且它的源码调用了 visionOS SDK 中不存在的 API。2026 年 6 月，这些代码被替换成了占位内容；2026 年 10 月，整个包被从头重写。[CHANGELOG.md](CHANGELOG.md) 列出了具体变更。

## 使用方法

下面的示例复制自
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift)。
示例应用和测试套件都会编译这个文件。

### 旋转轮播

`SpatialCarousel` 把视图摆放在一个环上。拖动会转动它，拖动结束时它会停在最近的视图上并更新 `selection`。点按某个视图或设置 `selection`，都会沿较短的方向把该视图转到正前方。

```swift
struct CarouselSample: View {
    @State private var selection = 0
    let destinations = [
        Destination(name: "Mountains", symbol: "mountain.2.fill"),
        Destination(name: "Ocean", symbol: "water.waves"),
        Destination(name: "Forest", symbol: "tree.fill"),
        Destination(name: "Desert", symbol: "sun.max.fill"),
        Destination(name: "City", symbol: "building.2.fill"),
        Destination(name: "Arctic", symbol: "snowflake"),
    ]

    var body: some View {
        VStack(spacing: 48) {
            SpatialCarousel(destinations, selection: $selection, radius: 0.25) { destination in
                SpatialCard {
                    Label(destination.name, systemImage: destination.symbol)
                        .font(.title2)
                        .frame(width: 180, height: 120)
                }
            }
            Text("Showing \(destinations[selection].name)")
        }
    }
}
```

### 让用户在限制范围内移动对象

地球仪始终留在 40 × 30 × 20 cm 的盒形范围内，缩放范围是一半到两倍，只绕竖直轴旋转，并且在旋转结束时吸附到 45°。

```swift
struct ManipulationSample: View {
    @State private var globe = ManipulationState(constraints: ManipulationConstraints(
        bounds: SpatialBounds(center: .zero, size: [0.4, 0.3, 0.2]),
        scaleRange: 0.5...2,
        rotation: .yaw,
        yawSnapAngle: .pi / 4
    ))

    var body: some View {
        Image(systemName: "globe.americas.fill")
            .font(.system(size: 120))
            .foregroundStyle(.blue)
            .spatialManipulation($globe)
    }
}
```

### 排列 RealityKit 实体

```swift
struct ShelfSample: View {
    var body: some View {
        RealityView { content in
            let shelf = Entity()
            for _ in 0..<7 {
                let sphere = ModelEntity(
                    mesh: .generateSphere(radius: 0.04),
                    materials: [SimpleMaterial(color: .systemBlue, isMetallic: false)]
                )
                shelf.addChild(sphere)
            }
            shelf.arrangeChildren(using: .arc(radius: 0.5, spacing: 0.12))
            content.add(shelf)
        }
    }
}
```

传入 `duration:`，即可在实体进入场景后以动画切换到新的布局。

### 把工具栏附加到窗口

在 visionOS 上，工具栏是窗口下方的 ornament；在 iOS 和 macOS 上，它绘制在内容底部之上。

```swift
struct PlayerSample: View {
    @State private var isPlaying = false

    var body: some View {
        Text(isPlaying ? "Playing" : "Paused")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbarOrnament(edge: .bottom) {
                Button("Back", systemImage: "backward.fill") {}
                Button(isPlaying ? "Pause" : "Play", systemImage: isPlaying ? "pause.fill" : "play.fill") {
                    isPlaying.toggle()
                }
                Button("Forward", systemImage: "forward.fill") {}
            }
    }
}
```

### 打开沉浸式空间

在应用中创建一个 `ImmersiveSpaceCoordinator`，把它放进环境（environment），并在空间的 `onDisappear` 中调用 `spaceDidDisappear(_:)`，这样当系统关闭空间时，按钮也会随之更新：

```swift
struct ImmersiveSample: View {
    @Environment(ImmersiveSpaceCoordinator.self) private var spaces

    var body: some View {
        VStack(spacing: 24) {
            ImmersiveSpaceToggle("Orbit", spaceID: "orbit", coordinator: spaces)
            if spaces.isBusy {
                ProgressView()
            }
        }
    }
}
```

[Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
介绍了场景的设置方式，以及 coordinator 在各种情况下的行为。

## 演示

示例应用在 Apple Vision Pro 模拟器上的截图，由
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh) 生成：

| 轮播                                                                                                                                        | 工具栏 ornament                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| ![轮播页面：Mountains 卡片位于最前面，Arctic 和 City 卡片在两侧向外转开，下方显示文字 Showing Mountains](docs/images/visionos-carousel.png) | ![组件页面：两张玻璃卡片、一颗点击区域更大的小星星，以及附加在窗口下方、带有后退、播放和前进按钮的工具栏](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="沉浸式空间：蓝色和青色的球体以不同高度分布在房间四周，画廊窗口中显示一个 Hide Orbit 按钮"></p>

五种布局各含 12 个元素，分别从上方（观看者在底部）和正面观察，箭头表示每个元素朝向的方向。图像由
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh) 根据各布局自身的位置结果渲染：

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="弧形、环形、网格、球面和螺旋布局从上方和正面观察的示意图，圆点表示元素，箭头表示各元素朝向的方向"></picture></p>

想亲自体验所有功能，请用 Xcode 打开
[`Examples/SpatialGallery`](Examples/SpatialGallery) 中的 `SpatialGallery.xcodeproj`，选择 **Apple Vision Pro** 模拟器、某个 iPhone 模拟器或 **My Mac**，然后按 **Run**。
[Examples/README.md](Examples/README.md) 介绍了每个页面。

## 文档

API 参考文档与文章：

- [API 参考](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  （DocC，从 `main` 发布到 GitHub Pages）
- 在 Xcode 中通过 **Product › Build Documentation** 在本地构建，或在命令行中执行：

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## 指南

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — 添加该包、把视图摆放到弧线上，以及坐标约定
  （[源文件](Sources/VisionUI/VisionUI.docc/GettingStarted.md)）。
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — 五种布局、SwiftUI 视图、RealityKit 实体、轮播和平面投影
  （[源文件](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)）。
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — 每个应用一个 coordinator、切换按钮，以及它处理的每一种情况
  （[源文件](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)）。
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — 范围、缩放区间、保持直立的旋转和吸附，可配合你自己的手势或 modifier 使用
  （[源文件](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)）。

## 系统要求

| 平台  | 最低版本         |
| --------------- | --------------------- |
| visionOS        | 2                     |
| iOS             | 18                    |
| macOS           | 15                    |
| 工具链 | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle` 以及接受环境中各项 actions 的 `ImmersiveSpaceActions` 初始化方法需要 visionOS，或 SwiftUI 提供沉浸式空间的 macOS 26。CI 使用 GitHub `macos-26` runner 镜像中的默认 Xcode 构建。该包使用 Xcode 27 开发。

## 架构

- `Sources/VisionUI/Geometry/` 包含 `SpatialPlacement`、共用的数学运算（朝向旋转、yaw、角度回绕和吸附），以及本包以 `+y` 为上的米与 SwiftUI 以 `+y` 为下的点之间的转换。
- `Layouts/` 包含 `SpatialLayout` 协议、五种布局和 `offset(_:)`。布局是一个把数量转换为位置的值，它对视图和实体一无所知。
- `Views/` 负责摆放 SwiftUI 视图：在 visionOS 上使用 `offset(z:)` 和 `rotation3DEffect`，并依据环境中的 `physicalMetrics`；在 iOS 和 macOS 上则通过 `FlatProjection`。
- `RealityKit/` 把位置应用到实体上。`Spaces/` 包含沉浸式空间 coordinator，它只通过 `ImmersiveSpaceActions` 调用系统，因此测试可以用闭包来驱动它。
- `Manipulation/` 包含带约束的状态（每个手势有一个起始值），以及用手势为其提供输入的 modifier。`Components/` 包含卡片、工具栏、ornament、点击目标和深度 modifier。
- 每个公开输入都在进入的地方做检查：数量对照 `SpatialLayoutLimits`，长度和角度检查 NaN、无穷大和溢出。测试会把这类数值传给每种布局、投影、操控状态和轮播。

在本地运行测试：

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## 路线图

- 把该包添加到 Swift Package Index；`.spi.yml` 已经在仓库中。
- 跟随 ARKit 检测到的表面（例如墙面或桌面）的布局，用于沉浸式空间。
- 沿弧线滚动的轮播变体，适用于较长的列表。

## 参与贡献

欢迎参与贡献。提交 pull request 之前，请先阅读[贡献指南](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md)和[行为准则](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md)。如发现安全问题，请按照[安全策略](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md)私下报告。

## 许可证

基于 MIT 许可证发布。详见 [LICENSE](LICENSE)。
