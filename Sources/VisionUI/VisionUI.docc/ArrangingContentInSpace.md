# Arranging Content in Space

Choose a layout, place SwiftUI views or RealityKit entities with it, and know how it behaves
on a flat screen.

## Overview

A ``SpatialLayout`` turns an item count into placements: one position, in meters, and one
orientation per item, around the layout's own origin. The layout does not know what it places,
so the same value arranges SwiftUI views, RealityKit entities or anything else you position
yourself.

### Pick a layout

| Layout         | Shape                                                                | Settings                                                    |
| -------------- | -------------------------------------------------------------------- | ----------------------------------------------------------- |
| ``ArcLayout``    | A curve that bends toward the viewer; the middle item at the origin. | `radius`, `spacing` along the arc, `maximumAngle`, `facing` |
| ``RingLayout``   | A closed circle around the origin; the first item at the front.      | `radius`, `rotation`, `facing`                              |
| ``GridLayout``   | Columns, rows, then layers behind, centered on the occupied cells.   | `columns`, `rows`, `spacing` per axis                       |
| ``SphereLayout`` | A Fibonacci spiral over a sphere, top to bottom.                     | `radius`, `facing`                                          |
| ``HelixLayout``  | A spiral that rises around the vertical axis, centered vertically.   | `radius`, `rise`, `itemsPerTurn`, `facing`                  |

``SpatialFacing`` sets where curved layouts turn their items: toward the center of the curve,
away from it, or straight at the viewer. Use ``SpatialLayout/offset(_:)`` to move a whole layout,
for example to put a ring's front item at the origin.

Each layout also has a shorthand for use where a layout is expected:

```swift
SpatialLayoutView(.ring(radius: 0.3), albums) { album in AlbumCover(album) }
```

### Place SwiftUI views

``SpatialLayoutView`` places one view per element of a collection. On visionOS each view is moved
with `offset(z:)` and turned with `rotation3DEffect`, and meters are converted to points by the
environment's `physicalMetrics`, so a layout measured in meters keeps its size whatever the
window's distance.

A visionOS window shows content in front of its plane but not behind it, so layouts that extend
behind the origin, such as a ring or a sphere, belong in a volume:

```swift
WindowGroup(id: "shelf") {
    SpatialLayoutView(.sphere(radius: 0.3), photos) { photo in
        PhotoTile(photo)
    }
}
.windowStyle(.volumetric)
.defaultSize(width: 0.8, height: 0.8, depth: 0.8, in: .meters)
```

Use ``SwiftUICore/View/spatialPlacement(_:projection:)`` to apply a single placement to a view of
your own.

### Place RealityKit entities

`Entity.arrangeChildren(using:duration:timingFunction:)` places an entity's children in the order
they were added. Pass a duration to animate them to their new places once the entity is in a
scene; each child keeps its scale.

```swift
RealityView { content in
    let shelf = Entity()
    for _ in 0..<7 {
        shelf.addChild(ModelEntity(mesh: .generateSphere(radius: 0.04)))
    }
    shelf.arrangeChildren(using: .arc(radius: 0.5, spacing: 0.12))
    content.add(shelf)
}
```

`Entity.arrange(_:using:relativeTo:duration:timingFunction:)` places entities that do not share a
parent, in the space of a reference entity.

### Turn a ring with a drag

``SpatialCarousel`` puts views on an outward-facing ring and turns it with a horizontal drag; a
drag the length of the radius turns it by one radian. When the drag ends the ring settles on the
nearest view, and the `selection` binding holds its index. Tapping a view, or setting the
selection, turns the ring the short way round with ``RingLayout/rotation(bringingToFront:count:from:)``.

### On iOS and macOS

Views there have no depth, so ``FlatProjection`` draws the layout as seen from the front:
`x` and `y` become an offset at 1000 points per meter by default, nearer items are larger and
drawn on top, and the yaw becomes a rotation effect. Pass your own projection to change the
scale or flatten the depth with a larger `viewerDistance`.

### Limits

A layout allocates one placement per item, so counts are clamped to
``SpatialLayoutLimits/maximumItemCount``: a count read from a file cannot exhaust memory.
Radii, spacings and rises are clamped to ``SpatialLayoutLimits/maximumLength`` so positions stay
finite, and NaN arguments fall back to the defaults each initializer documents.
