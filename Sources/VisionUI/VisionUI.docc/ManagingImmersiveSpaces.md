# Managing Immersive Spaces

Open and dismiss an immersive space from a button that always matches what is on screen.

## Overview

An app shows one immersive space at a time, and the system takes a moment to open or dismiss it.
A flag that you set yourself goes wrong in three common cases: the person taps the button again
during the transition, the app opens a second space while one is open, or the person closes the
space with the Digital Crown and the app never hears about it.

``ImmersiveSpaceCoordinator`` keeps a single ``ImmersiveSpaceCoordinator/Phase`` and handles each
case.

### Share one coordinator

Create the coordinator once, in the app, and pass it to the views that need it:

```swift
@main
struct PlanetariumApp: App {
    @State private var spaces = ImmersiveSpaceCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(spaces)
        }
        ImmersiveSpace(id: "planetarium") {
            PlanetariumView()
                .onDisappear { spaces.spaceDidDisappear("planetarium") }
        }
    }
}
```

The `onDisappear` call is what keeps the phase right when the system closes the space.

### Add a button

``ImmersiveSpaceToggle`` reads `openImmersiveSpace` and `dismissImmersiveSpace` from the
environment and sends its requests through the coordinator. It is labeled "Show" or "Hide" with
the space's name and is disabled while a request is in progress:

```swift
struct ContentView: View {
    @Environment(ImmersiveSpaceCoordinator.self) private var spaces

    var body: some View {
        ImmersiveSpaceToggle("Planetarium", spaceID: "planetarium", coordinator: spaces)
    }
}
```

For your own label, use ``ImmersiveSpaceToggle/init(spaceID:coordinator:label:)``, which passes
whether the space is open.

### Call the coordinator yourself

Build ``ImmersiveSpaceActions`` from the environment and call
``ImmersiveSpaceCoordinator/open(_:using:)``, ``ImmersiveSpaceCoordinator/dismiss(using:)`` or
``ImmersiveSpaceCoordinator/toggle(_:using:)``:

```swift
let actions = ImmersiveSpaceActions(open: openImmersiveSpace, dismiss: dismissImmersiveSpace)
switch await spaces.open("planetarium", using: actions) {
case .opened, .alreadyOpen: break
case .userCancelled: showHint = true
case .failed: showError = true
case .busy: break   // another request is in progress; nothing changed
}
```

| Situation                                                | What the coordinator does                                                                                                              |
| -------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| A request arrives while another is in progress           | Returns ``ImmersiveSpaceCoordinator/OpenResult/busy`` and changes nothing.                                                               |
| The requested space is already open                      | Returns ``ImmersiveSpaceCoordinator/OpenResult/alreadyOpen`` without calling the system.                                                 |
| A different space is open                                | Dismisses it, then opens the requested one.                                                                                            |
| The person declines, or the system cannot open the space | Returns ``ImmersiveSpaceCoordinator/OpenResult/userCancelled`` or ``ImmersiveSpaceCoordinator/OpenResult/failed`` and goes back to closed. |
| The system closes the space                              | ``ImmersiveSpaceCoordinator/spaceDidDisappear(_:)`` sets the phase to closed.                                                            |
| An old request answers after a newer one started         | Its answer is ignored.                                                                                                                 |

### Test without a device

``ImmersiveSpaceActions`` also takes closures, so tests and previews can stand in for the system:

```swift
let actions = ImmersiveSpaceActions(open: { _ in .opened }, dismiss: {})
let spaces = ImmersiveSpaceCoordinator()
await spaces.open("planetarium", using: actions)
#expect(spaces.openSpaceID == "planetarium")
```
