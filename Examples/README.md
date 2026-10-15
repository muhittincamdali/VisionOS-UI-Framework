# Examples

## SpatialGallery

An app for visionOS, iOS and macOS that shows every part of the package. It uses the package
from this checkout (a local package reference to `../..`), so it always shows the current code.

| Page            | What it shows                                                                                                                                                                                                                                                    |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Quick start     | The README's first sample: five cards on an arc.                                                                                                                                                                                                                 |
| Layouts         | The five layouts with a picker and an item count. On iOS and macOS the tiles are drawn with the flat projection; on visionOS the page shows a diagram of the placements from above and from the front, and a button opens a volume with the tiles in real depth. |
| Carousel        | `SpatialCarousel`: drag to turn, tap a card, or swipe up and down with VoiceOver.                                                                                                                                                                                |
| Manipulation    | `spatialManipulation` with bounds, a scale range, upright rotation and 45° snapping, and a readout of the state.                                                                                                                                                 |
| Components      | `SpatialCard`, `spatialHitTarget` and `toolbarOrnament`.                                                                                                                                                                                                         |
| RealityKit      | Spheres placed with `Entity.arrangeChildren(using:duration:)`, animated when the layout changes. On visionOS they are shown in the volume.                                                                                                                       |
| Immersive space | visionOS only: `ImmersiveSpaceToggle` opens 60 spheres spread over a sphere around you.                                                                                                                                                                          |

Run it:

1. Open `Examples/SpatialGallery/SpatialGallery.xcodeproj` in Xcode 26 or later.
2. Choose the **SpatialGallery** scheme and an **Apple Vision Pro** simulator, an iPhone or iPad
   simulator, or **My Mac** as the run destination.
3. Press **Run** (⌘R).

The visionOS simulator is a separate download: in Xcode, open **Settings › Components** and get
**visionOS**, or run `xcodebuild -downloadPlatform visionOS`.

From the command line:

```sh
cd Examples/SpatialGallery
xcodebuild build -scheme SpatialGallery -destination 'generic/platform=visionOS Simulator'
xcodebuild build -scheme SpatialGallery -destination 'generic/platform=iOS Simulator'
xcodebuild build -scheme SpatialGallery -destination 'platform=macOS'
```

Launch arguments open a page or a scene directly; `scripts/capture-gallery.sh` uses them for
the README screenshots:

| Argument          | Effect                                                                   |
| ----------------- | ------------------------------------------------------------------------ |
| `-page <name>`    | Opens a page by its name, for example `-page Carousel`.                  |
| `-layout <name>`  | Picks a layout: `Arc`, `Ring`, `Grid`, `Sphere` or `Helix`.              |
| `-spheres`        | Shows RealityKit spheres in the volume instead of SwiftUI tiles.         |
| `-open-volume`    | visionOS: opens the volume.                                              |
| `-open-immersive` | visionOS: opens the immersive space through `ImmersiveSpaceCoordinator`. |

| File                                                                               | What it holds                                                                                                                         |
| ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| [`ReadmeSamples.swift`](SpatialGallery/SpatialGallery/ReadmeSamples.swift)         | The README's code samples. The package's tests compile this file through the symlink `Tests/VisionUITests/ReadmeSamples.swift`.       |
| [`LayoutCatalog.swift`](SpatialGallery/SpatialGallery/LayoutCatalog.swift)         | The layouts with the settings the gallery uses, the tiles and the placement diagram. The README's layout images are rendered from it. |
| [`GalleryView.swift`](SpatialGallery/SpatialGallery/GalleryView.swift)             | The app's pages.                                                                                                                      |
| [`RealityScenes.swift`](SpatialGallery/SpatialGallery/RealityScenes.swift)         | The RealityKit content, the volume and the immersive space.                                                                           |
| [`SpatialGalleryApp.swift`](SpatialGallery/SpatialGallery/SpatialGalleryApp.swift) | The scenes and the launch arguments.                                                                                                  |

The project file is made with [XcodeGen](https://github.com/yonaskolb/XcodeGen) from
[`project.yml`](SpatialGallery/project.yml) and committed, so you only need XcodeGen after
editing `project.yml`.
