# Contributing

Thanks for taking the time to improve VisionOS UI Framework.

## Reporting bugs

Open an issue with:

- the API you used and its arguments (the layout and its settings, the constraints, the
  coordinator calls),
- what you expected and what happened (a simulator screenshot helps for anything visual),
- where it ran: visionOS window, volume or immersive space, or iOS or macOS,
- the OS version and the Xcode version.

## Pull requests

1. Fork the repository and branch from `main`.
2. Keep each pull request focused on one change.
3. Run the tests on the three platforms:

    ```sh
    swift test                                    # macOS
    xcodebuild test -scheme VisionUI \
      -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
    xcodebuild test -scheme VisionUI \
      -destination 'platform=iOS Simulator,name=iPhone 17'
    ```

    The visionOS simulator is a separate download: `xcodebuild -downloadPlatform visionOS`.

4. If you change a README code sample, change the copy in
   `Examples/SpatialGallery/SpatialGallery/ReadmeSamples.swift` as well. That file is what gets
   compiled: by the example app, and by the tests through the symlink
   `Tests/VisionUITests/ReadmeSamples.swift`. Build the app with:

    ```sh
    cd Examples/SpatialGallery
    xcodebuild build -scheme SpatialGallery -destination 'generic/platform=visionOS Simulator'
    ```

5. If a layout changes, regenerate the diagrams with `scripts/generate-screenshots.sh`; if the
   example app looks different, recapture its screenshots with `scripts/capture-gallery.sh`.
6. `README.md` has translations (`README.<language>.md`). Each one records the version of
   `README.md` it follows, and CI fails while a translation is behind. If you change `README.md`
   and cannot update the translations, say so in the pull request and they will be updated
   before it is merged.

## Adding a layout

1. Add a type in `Sources/VisionUI/Layouts/` that conforms to `SpatialLayout`. Start
   `placements(count:)` with `SpatialLayoutLimits.clampedCount(_:)`, pass every length through
   `SpatialLayoutLimits.clampedLength(_:minimum:fallback:)`, and document what each out-of-range
   value becomes.
2. Add a static shorthand in `SpatialLayout.swift`, so `.yourLayout(...)` works where a layout is
   expected.
3. Add tests that check the geometry itself (distances, spacing, facing) and a case with NaN,
   infinite, negative and huge arguments, and add the layout to `LayoutLimitTests.layouts`.
4. Add it to `LayoutKind` in the example app (which also puts it in the README diagram), to the
   DocC landing page and to the table in `ArrangingContentInSpace.md`.

## Coordinates

Layouts, placements and the manipulation state use meters and RealityKit's axes: `+x` right,
`+y` up, `+z` toward the viewer. SwiftUI's 3D effects use points with `+y` down. Convert only
through `SpatialUnits`, which also flips quaternions between the two, and keep the conversion at
the edge where a view or an entity is changed.

## Code style

- Follow the [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/).
- The package builds in the Swift 6 language mode; new code should not add warnings.
- Document public API with DocC comments (`///`); `xcodebuild docbuild` should finish without
  warnings.
- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/)
  (`feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `ci:`, `chore:`).

## License

By contributing, you agree that your contributions are licensed under the MIT license in
[LICENSE](LICENSE).
