# Getting Started

Add the package, place views on an arc, and run the result on visionOS, iOS and macOS.

## Overview

VisionUI needs Xcode 26 or later. It supports visionOS 2, iOS 18 and macOS 15 and has no
dependencies.

### Add the package

In Xcode, choose **File › Add Package Dependencies…**, paste
`https://github.com/muhittincamdali/VisionOS-UI-Framework.git` into the search field, keep
**Up to Next Major Version** from `2.0.0`, and add the **VisionUI** library to your app target.

In a `Package.swift`:

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

### Place views on an arc

Create a visionOS app in Xcode (**File › New › Project… › visionOS › App**) and replace
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

Run it on the Apple Vision Pro simulator. The five cards curve toward you: the middle one in the
window's plane, the outer ones closer and turned to face the arc's center, 0.6 m in front of the
window. Change the radius to `0.3` for a tighter curve.

Add **iPhone** or **Mac** as a destination of the same target and run it there: the same code
draws the arc as seen from the front, with the outer cards larger because they are closer.

### Know the coordinates

Layouts work in meters with RealityKit's axes: `+x` right, `+y` up, `+z` toward the viewer. An
item with no rotation shows its front, its `+z` side, to the viewer. SwiftUI's own 3D effects use
points with `+y` down; ``SpatialLayoutView`` converts between the two with the system's physical
metrics, so you never handle points yourself.

### Next steps

- <doc:ArrangingContentInSpace> describes each layout and how to use it with RealityKit.
- <doc:ManagingImmersiveSpaces> adds an immersive space with a button that stays in step.
- <doc:ConstrainingManipulation> lets people move an object within limits.
