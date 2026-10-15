# Constraining Manipulation

Let people move, resize and turn an object with gestures, inside the limits you set.

## Overview

``ManipulationState`` holds an object's position, uniform scale and orientation.
``ManipulationConstraints`` limits them: a ``SpatialBounds`` box for the position, a scale range,
a rotation mode and an optional snap angle. The state applies gesture values and keeps the
object inside the limits at every step.

### Attach it to a view

```swift
struct GlobeView: View {
    @State private var globe = ManipulationState(constraints: ManipulationConstraints(
        bounds: SpatialBounds(center: .zero, size: [0.4, 0.3, 0.2]),
        scaleRange: 0.5...2,
        rotation: .yaw,
        yawSnapAngle: .pi / 4
    ))

    var body: some View {
        Model3D(named: "Globe")
            .spatialManipulation($globe)
    }
}
```

On visionOS, ``SwiftUICore/View/spatialManipulation(_:pointsPerMeter:)`` moves the view with a 3D
drag, scales it with a pinch and turns it with a two-handed rotation; distances are converted to
meters with the system's physical metrics, so the bounds are real distances. On iOS and macOS a
drag moves the view on screen, a pinch scales it, and a two-finger rotation turns it around the
axis that points at the viewer.

On visionOS 26 and later, SwiftUI's own `manipulable()` modifiers handle free-form manipulation.
Use this state when you need bounds, a scale range, upright rotation or snapping, when you
support visionOS 2, or when the same code also runs on iOS and macOS.

### Drive it from your own gestures

Each gesture reports its change since it began, so call the matching method while it changes and
the matching end method when it ends:

| Gesture  | While it changes                                                   | When it ends                      |
| -------- | ------------------------------------------------------------------ | --------------------------------- |
| Drag     | ``ManipulationState/drag(translation:)`` with meters since the start | ``ManipulationState/endDrag()``     |
| Pinch    | ``ManipulationState/magnify(by:)`` with the factor since the start   | ``ManipulationState/endMagnify()``  |
| Rotation | ``ManipulationState/rotate(by:)`` with the rotation since the start  | ``ManipulationState/endRotation()`` |

The state keeps a separate starting value for each gesture, so a drag and a pinch at the same time
each apply to their own start, and the pinch ending first does not make the drag jump.

For a RealityKit entity, set its transform from ``ManipulationState/matrix``, or from
``ManipulationState/position``, ``ManipulationState/scale`` and ``ManipulationState/orientation``.

### Rotation modes

| Mode                                      | Behavior                                                                                                                                                                  |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ``ManipulationConstraints/Rotation/free``   | Any rotation.                                                                                                                                                             |
| ``ManipulationConstraints/Rotation/yaw``    | Only the part of a rotation around the vertical axis, so the object stays upright. With `yawSnapAngle`, the yaw snaps to a multiple of that angle when the rotation ends. |
| ``ManipulationConstraints/Rotation/locked`` | No rotation.                                                                                                                                                              |

### Values that are ignored

Gesture values come from hardware and can glitch. NaN and infinite translations, factors and
rotations, magnifications of zero or less, and zero quaternions are ignored, and a scale that
would overflow is not applied. A finite quaternion of any length is normalized without
overflowing, so a very large one still turns the object instead of collapsing it. Scale ranges that are not positive and finite are replaced, and
bounds with NaN or infinite corners are clamped to a finite box. Without bounds, the position
still stays within ±``SpatialLayoutLimits/maximumLength`` on each axis, so large drags cannot add
up to an infinite position and the object always stays within reach. Changing ``ManipulationState/constraints`` moves the object inside the new limits.
