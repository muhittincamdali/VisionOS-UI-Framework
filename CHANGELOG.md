# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2026-10-15

A new package with a new API, written from scratch. The 1.0.0 manifest declared
`.visionOS(.v1_0)`, a platform version that does not exist, so Swift Package Manager could not
resolve the package, and with that fixed its sources still failed to compile against the
visionOS SDK (for example `RealityViewContent.physicsWorld`, `SpatialDragGesture` and
`UIAccessibility.isHighContrastEnabled`, none of which exist). In June 2026 the code was
replaced with placeholders: a version constant, a modifier that only drew a shadow, a
`VolumetricWindowManager.present()` that printed a line, and circuit-breaker, retry and event-bus
types that no target compiled. Because every public name changes, this release is a new major
version.

### Added

- `SpatialLayout` with five layouts that return a position in meters and an orientation per
  item: `ArcLayout`, `RingLayout` (with `frontIndex(count:)`,
  `rotation(bringingToFront:count:from:)` and `snappedRotation(_:count:)`), `GridLayout`,
  `SphereLayout` and `HelixLayout`, plus `offset(_:)` and `SpatialFacing`.
- `SpatialLayoutView` and `spatialPlacement(_:projection:)` for SwiftUI views: real depth on
  visionOS through the system's physical metrics, and `FlatProjection` on iOS and macOS.
- `SpatialCarousel`: a ring of views turned by a drag, settling on the nearest view, with a
  `selection` binding, tap to select, a VoiceOver adjustable action and Reduce Motion support.
- `Entity.arrangeChildren(using:duration:timingFunction:)`,
  `Entity.arrange(_:using:relativeTo:duration:timingFunction:)`, `Entity.apply(_:)` and
  `Transform(_:scale:)` for RealityKit.
- `ImmersiveSpaceCoordinator`, `ImmersiveSpaceActions` and `ImmersiveSpaceToggle`: one request at
  a time, switching between spaces, `.alreadyOpen`, `.userCancelled`, `.failed` and `.busy`
  results, system dismissal through `spaceDidDisappear(_:)`, and late answers of replaced
  requests ignored.
- `ManipulationState`, `ManipulationConstraints`, `SpatialBounds` and
  `spatialManipulation(_:pointsPerMeter:)`: drag, pinch and rotation within bounds and a scale
  range, free, upright or locked rotation, yaw snapping, and one starting value per gesture.
  Without bounds, positions stay within ±10 km on each axis.
- `SpatialCard`, `SpatialToolbar`, `SpatialToolbarButtonStyle`, `toolbarOrnament(edge:content:)`,
  `spatialHitTarget(minimum:)`, `spatialDepth(_:)` and `HitTarget` with the default control
  sizes from Apple's Human Interface Guidelines.
- Input checks on every public API: item counts are capped at 4096, lengths at 10 km, columns
  and rows before they are multiplied, NaN or infinite values fall back to documented
  defaults or are ignored, and placements from custom layouts are made finite before they reach
  views or entities.
- 97 Swift Testing tests that run on macOS and on an iPhone simulator, 87 of which also run on a
  visionOS simulator: geometry of every layout, hostile arguments, the coordinator's cases with a
  fake system, the manipulation state, RealityKit arrangement, and pixels of rendered views.
- DocC catalog with four articles (Getting Started, Arranging Content in Space, Managing
  Immersive Spaces, Constraining Manipulation), built and deployed to GitHub Pages by
  `docs.yml`.
- `Examples/SpatialGallery`: a visionOS, iOS and macOS app with a page for each part of the
  package, a volume and an immersive space. The README samples are compiled by the app and by
  the tests.
- README images: layout diagrams rendered from code by `scripts/generate-screenshots.sh`, and
  visionOS simulator screenshots captured by `scripts/capture-gallery.sh`.
- `.spi.yml` for the Swift Package Index.

### Changed

- The package is named `VisionUI`, requires Swift tools 6.2 and builds in the Swift 6 language
  mode.
- Supports visionOS 2, iOS 18 and macOS 15.
- CI uses the shared workflows of `muhittincamdali/.github`, pinned to a commit, runs the tests
  on macOS, an iPhone simulator and a visionOS simulator, and builds the example app for all
  three platforms.

### Removed

- Every 1.0.0 type and the placeholder code added in June 2026.
- The CocoaPods podspec, the `Documentation/` folder and the loose example files, none of which
  matched code that compiled.

## [1.0.0] - 2026-02-03

First tagged release.

[Unreleased]: https://github.com/muhittincamdali/VisionOS-UI-Framework/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/muhittincamdali/VisionOS-UI-Framework/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/muhittincamdali/VisionOS-UI-Framework/releases/tag/v1.0.0
