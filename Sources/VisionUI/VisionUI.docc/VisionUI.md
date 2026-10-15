# ``VisionUI``

Place SwiftUI views and RealityKit entities in 3D, open immersive spaces without races, and let
people move objects within limits, on visionOS with the same code running on iOS and macOS.

## Overview

VisionUI is a Swift package for visionOS 2 and later. Its parts work on their own:

- **Spatial layouts** compute a position and an orientation for each item: on an arc, a ring, a
  grid, a sphere or a helix. ``SpatialLayoutView`` places SwiftUI views with them, and
  `Entity.arrangeChildren(using:duration:timingFunction:)` places RealityKit entities.
- ``SpatialCarousel`` is a ring of views that a person turns with a drag.
- ``ImmersiveSpaceCoordinator`` opens and dismisses immersive spaces one request at a time and
  follows the system when it closes a space.
- ``ManipulationState`` and ``SwiftUICore/View/spatialManipulation(_:pointsPerMeter:)`` move, scale
  and turn an object inside bounds, a scale range and an upright rotation.
- ``SpatialCard``, ``SpatialToolbar``, ``SwiftUICore/View/toolbarOrnament(edge:content:)`` and
  ``SwiftUICore/View/spatialHitTarget(minimum:)`` follow the platform's look and target sizes.

On iOS and macOS, where views have no depth, layouts are drawn as seen from the front with
``FlatProjection``, so a multiplatform app keeps one code path.

Every API treats its arguments as untrusted: counts, lengths and angles are clamped, NaN and
infinity are replaced or ignored, and nothing allocates memory in proportion to a count beyond
``SpatialLayoutLimits/maximumItemCount``.

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:ArrangingContentInSpace>

### Layouts

- ``SpatialLayout``
- ``SpatialPlacement``
- ``ArcLayout``
- ``RingLayout``
- ``GridLayout``
- ``SphereLayout``
- ``HelixLayout``
- ``OffsetLayout``
- ``SpatialFacing``
- ``SpatialLayoutLimits``
- ``SpatialMath``

### Showing views in space

- ``SpatialLayoutView``
- ``SpatialCarousel``
- ``FlatProjection``

### Immersive spaces

- <doc:ManagingImmersiveSpaces>
- ``ImmersiveSpaceCoordinator``
- ``ImmersiveSpaceActions``
- ``ImmersiveSpaceToggle``

### Manipulation

- <doc:ConstrainingManipulation>
- ``ManipulationState``
- ``ManipulationConstraints``
- ``SpatialBounds``

### Components

- ``SpatialCard``
- ``SpatialToolbar``
- ``SpatialToolbarButtonStyle``
- ``OrnamentEdge``
- ``HitTarget``
