<!-- brand:start -->

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/banner-light.svg" alt="VisionOS UI Framework: Spatial layouts, a carousel, immersive spaces and bounded manipulation for visionOS apps."></picture></p>

<!-- lang-selector:start -->
<p align="center"><a href="README.md">English</a> · <a href="README.tr.md">Türkçe</a> · <a href="README.zh-CN.md">简体中文</a> · <a href="README.ja.md">日本語</a> · <a href="README.ko.md">한국어</a> · <a href="README.es.md">Español</a> · <a href="README.de.md">Deutsch</a> · <a href="README.fr.md">Français</a> · <a href="README.pt-BR.md">Português (Brasil)</a> · <a href="README.ru.md">Русский</a></p>
<!-- lang-selector:end -->

<p align="center">
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml"><img src="https://github.com/muhittincamdali/VisionOS-UI-Framework/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/releases"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-version-light.svg" alt="Latest version: v2.0.0"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-platforms-light.svg" alt="Supported platforms: visionOS 2+ · iOS 18+ · macOS 15+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/Package.swift"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-language-light.svg" alt="Language version: Swift 6.2+"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/LICENSE"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/badge-license-light.svg" alt="License: MIT"></picture></a>
</p>

<p align="center">
<a href="#quick-start"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-start-en-light.svg" alt="Get started"></picture></a>
<a href="https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-docs-en-light.svg" alt="Documentation"></picture></a>
<a href="https://github.com/muhittincamdali/VisionOS-UI-Framework/tree/main/Examples"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-en-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-en-light.svg"><img src="https://raw.githubusercontent.com/muhittincamdali/VisionOS-UI-Framework/main/.github/brand/button-examples-en-light.svg" alt="Examples"></picture></a>
</p>

<!-- brand:end -->
A Swift package for visionOS apps: it places SwiftUI views and RealityKit entities in 3D with
five layouts (arc, ring, grid, sphere, helix), turns a ring of views into a carousel, opens and
dismisses immersive spaces without the races of a hand-kept flag, and lets people move, resize
and turn objects inside the limits you set. It is for developers who want these spatial building
blocks without writing the geometry and state handling themselves. The same code runs on iOS and
macOS, where layouts are drawn as seen from the front, and the package has no dependencies.

<p align="center"><img src="docs/images/visionos-quick-start.png" width="760" alt="The example app on the Apple Vision Pro simulator: five glass cards named after planets on an arc that bends toward the viewer, the outer cards closer and turned toward the middle"></p>

## Highlights

- **Five spatial layouts** — arc, ring, grid, sphere and helix return a position in meters and
  an orientation per item, for SwiftUI views with `SpatialLayoutView` and for RealityKit
  entities with `arrangeChildren(using:)`.
- **Immersive spaces without races** — `ImmersiveSpaceCoordinator` refuses a second request
  during a transition, dismisses one space before opening another, and follows the system when
  the person closes a space with the Digital Crown.
- **Manipulation within limits** — `ManipulationState` keeps a dragged, pinched or turned object
  inside a box and a scale range, upright if you want, with snapping, and ignores glitched
  gesture values.
- **Platform-sized components** — `SpatialCard`, a toolbar that becomes an ornament on
  visionOS, and hit targets sized to Apple's guidelines (60 pt on visionOS, 44 on iOS, 28 on
  macOS).
- **Untrusted input is safe** — counts are capped at 4096 items, lengths at 10 km, and NaN or
  infinite arguments fall back to documented defaults, so a value read from a file cannot
  exhaust memory or produce an infinite position.
- **Tested on three platforms** — 97 Swift Testing tests run on macOS and on an iPhone
  simulator; 87 of them, all but the pixel tests, also run on a visionOS simulator.

### What's included

| Area             | API                                                                                                                              |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Layouts          | `ArcLayout`, `RingLayout`, `GridLayout`, `SphereLayout`, `HelixLayout`, `offset(_:)`, `SpatialFacing`                            |
| SwiftUI          | `SpatialLayoutView`, `SpatialCarousel`, `spatialPlacement(_:projection:)`, `FlatProjection`                                      |
| RealityKit       | `Entity.arrangeChildren(using:duration:timingFunction:)`, `Entity.arrange(_:using:relativeTo:)`, `Transform(_:scale:)`           |
| Immersive spaces | `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions`, `ImmersiveSpaceToggle`                                                     |
| Manipulation     | `ManipulationState`, `ManipulationConstraints`, `SpatialBounds`, `spatialManipulation(_:pointsPerMeter:)`                        |
| Components       | `SpatialCard`, `SpatialToolbar`, `toolbarOrnament(edge:content:)`, `spatialHitTarget(minimum:)`, `spatialDepth(_:)`, `HitTarget` |

## Quick start

**1. Add the package**

In Xcode, choose **File › Add Package Dependencies…** and enter the repository URL:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Paste it into the search field at the top right of the window. Leave **Dependency Rule** at
**Up to Next Major Version** from `2.0.0`, then click **Add Package**. In the next window,
choose your app target next to **VisionUI** and click **Add Package** again.

**2. Import the module**

```swift
import VisionUI
```

Put this line at the top of the Swift file where you use the package, below `import SwiftUI`.

**3. Use it**

In a new visionOS app (**File › New › Project… › visionOS › App**), replace everything in
`ContentView.swift` with:

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

Choose the **Apple Vision Pro** simulator and press **Run** (⌘R). The five cards curve toward
you as in the picture above: the middle one in the window's plane, the outer ones closer and
turned toward the arc's center, 0.6 m in front of the window. Change the radius to `0.3` and run
again for a tighter curve. The same code also runs on an iPhone or a Mac, where the arc is drawn
as seen from the front.

## Installation

### Swift Package Manager

In Xcode, choose **File › Add Package Dependencies…** and enter the repository URL:

```text
https://github.com/muhittincamdali/VisionOS-UI-Framework.git
```

Or add it to the `dependencies` in your `Package.swift`:

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

Version 2.0.0 (October 2026) is a new package with a new API. The earlier release, 1.0.0
(February 2026), declared a platform version that does not exist (`.visionOS(.v1_0)`), so
Swift Package Manager could not resolve it, and its sources called APIs that are not in the
visionOS SDK. In June 2026 that code was replaced with placeholders, and in October 2026 the
package was written again from scratch. [CHANGELOG.md](CHANGELOG.md) lists what changed.

## Usage

The samples below are copied from
[`Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift`](Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift).
The example app and the test suite both compile that file.

### Turn a carousel

`SpatialCarousel` puts the views on a ring. A drag turns it, and when the drag ends it settles
on the nearest view and updates `selection`. Tapping a view or setting `selection` turns that
view to the front the short way round.

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

### Let people move an object within limits

The globe stays inside a 40 × 30 × 20 cm box, scales between half and double size, turns only
around the vertical axis and snaps to 45° when a turn ends.

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

### Arrange RealityKit entities

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

Pass `duration:` to animate the entities to a new layout once they are in a scene.

### Attach a toolbar to the window

On visionOS the toolbar is an ornament below the window; on iOS and macOS it is drawn over the
bottom of the content.

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

### Open an immersive space

Create one `ImmersiveSpaceCoordinator` in the app, put it in the environment, and call
`spaceDidDisappear(_:)` from the space's `onDisappear`, so the button also follows when the
system closes the space:

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
shows the scene setup and what the coordinator does in each case.

## Demo

The example app on the Apple Vision Pro simulator, captured by
[`scripts/capture-gallery.sh`](scripts/capture-gallery.sh):

| Carousel                                                                                                                                                                           | Toolbar ornament                                                                                                                                                                             |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![The carousel page: the Mountains card at the front, the Arctic and City cards turned away at the sides, and the text Showing Mountains below](docs/images/visionos-carousel.png) | ![The components page: two glass cards, a small star with a larger tap area, and a toolbar with back, play and forward buttons attached below the window](docs/images/visionos-ornament.png) |

<p align="center"><img src="docs/images/visionos-immersive.png" width="760" alt="The immersive space: blue and teal spheres spread around the room at different heights, with the gallery window showing a Hide Orbit button"></p>

The five layouts with 12 items each, seen from above (the viewer at the bottom) and from the
front, with an arrow for the way each item faces. Rendered from the layouts' own placements by
[`scripts/generate-screenshots.sh`](scripts/generate-screenshots.sh):

<p align="center"><picture><source media="(prefers-color-scheme: dark)" srcset="docs/images/layouts-dark.png"><img src="docs/images/layouts-light.png" width="620" alt="Diagrams of the arc, ring, grid, sphere and helix layouts from above and from the front, with dots for the items and arrows for the direction each one faces"></picture></p>

To try everything yourself, open `SpatialGallery.xcodeproj` in
[`Examples/SpatialGallery`](Examples/SpatialGallery) with Xcode, choose the **Apple Vision Pro**
simulator, an iPhone simulator or **My Mac**, and press **Run**.
[Examples/README.md](Examples/README.md) describes each page.

## Documentation

Reference documentation and articles:

- [API reference](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/)
  (DocC, published to GitHub Pages from `main`)
- Build it locally in Xcode with **Product › Build Documentation**, or from the command line:

```sh
xcodebuild docbuild -scheme VisionUI -destination 'generic/platform=visionOS Simulator'
```

## Guides

- [Getting Started](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/gettingstarted)
  — add the package, place views on an arc, and the coordinate conventions
  ([source](Sources/VisionUI/VisionUI.docc/GettingStarted.md)).
- [Arranging Content in Space](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/arrangingcontentinspace)
  — the five layouts, SwiftUI views, RealityKit entities, the carousel and the flat projection
  ([source](Sources/VisionUI/VisionUI.docc/ArrangingContentInSpace.md)).
- [Managing Immersive Spaces](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/managingimmersivespaces)
  — one coordinator per app, the toggle, and every case it handles
  ([source](Sources/VisionUI/VisionUI.docc/ManagingImmersiveSpaces.md)).
- [Constraining Manipulation](https://muhittincamdali.github.io/VisionOS-UI-Framework/documentation/visionui/constrainingmanipulation)
  — bounds, scale ranges, upright rotation and snapping, with your own gestures or the modifier
  ([source](Sources/VisionUI/VisionUI.docc/ConstrainingManipulation.md)).

## Requirements

| Platform  | Minimum version       |
| --------- | --------------------- |
| visionOS  | 2                     |
| iOS       | 18                    |
| macOS     | 15                    |
| Toolchain | Swift 6.2 · Xcode 26+ |

`ImmersiveSpaceToggle` and the `ImmersiveSpaceActions` initializer that takes the environment's
actions need visionOS, or macOS 26 where SwiftUI has immersive spaces. CI builds with the
default Xcode of GitHub's `macos-26` runner image. The package is developed with Xcode 27.

## Architecture

- `Sources/VisionUI/Geometry/` holds `SpatialPlacement`, the shared math (look-at rotation, yaw,
  angle wrapping and snapping) and the conversion between the package's meters with `+y` up and
  SwiftUI's points with `+y` down.
- `Layouts/` holds the `SpatialLayout` protocol, the five layouts and `offset(_:)`. A layout is a
  value that turns a count into placements; it knows nothing about views or entities.
- `Views/` places SwiftUI views: on visionOS with `offset(z:)` and `rotation3DEffect`, using the
  environment's `physicalMetrics`; on iOS and macOS through `FlatProjection`.
- `RealityKit/` applies placements to entities. `Spaces/` holds the immersive space coordinator,
  which calls the system only through `ImmersiveSpaceActions`, so tests drive it with closures.
- `Manipulation/` holds the constrained state, with one starting value per gesture, and the
  modifier that feeds it from gestures. `Components/` holds the card, toolbar, ornament, hit
  target and depth modifiers.
- Every public input is checked where it enters: counts against `SpatialLayoutLimits`, lengths
  and angles for NaN, infinity and overflow. The tests pass such values to every layout, the
  projection, the manipulation state and the carousel.

Run the tests locally:

```sh
swift test                                    # macOS
xcodebuild test -scheme VisionUI \
  -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
xcodebuild test -scheme VisionUI \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## Roadmap

- Add the package to the Swift Package Index; `.spi.yml` is already in the repository.
- Layouts that follow a surface found by ARKit, such as a wall or a table, in an immersive
  space.
- A carousel variant that scrolls along an arc, for long lists.

## Contributing

Contributions are welcome. Read the [contributing guide](https://github.com/muhittincamdali/VisionOS-UI-Framework/blob/main/CONTRIBUTING.md) and the [code of conduct](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md) before opening a pull request. Report security issues privately as described in the [security policy](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

## License

Released under the MIT license. See [LICENSE](LICENSE).
