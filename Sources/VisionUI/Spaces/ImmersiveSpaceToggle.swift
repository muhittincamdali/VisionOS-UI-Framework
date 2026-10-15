#if os(visionOS) || os(macOS)
import SwiftUI

/// A button that opens an immersive space, or dismisses it when it is open.
///
/// The button reads `openImmersiveSpace` and `dismissImmersiveSpace` from the environment and
/// sends every request through an ``ImmersiveSpaceCoordinator``, so taps during a transition do
/// nothing and the label always matches what is on screen. It is disabled while a request is in
/// progress.
///
/// ```swift
/// ImmersiveSpaceToggle("Planetarium", spaceID: "planetarium", coordinator: spaces)
/// ```
@available(visionOS 1.0, macOS 26.0, *)
public struct ImmersiveSpaceToggle<Label: View>: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    private let spaceID: String
    private let coordinator: ImmersiveSpaceCoordinator
    private let label: (_ isOpen: Bool) -> Label

    /// Creates a toggle with a custom label.
    ///
    /// - Parameters:
    ///   - spaceID: The identifier of the `ImmersiveSpace` scene.
    ///   - coordinator: The coordinator that tracks the app's immersive space.
    ///   - label: The button's label, given whether the space is open.
    public init(spaceID: String, coordinator: ImmersiveSpaceCoordinator, @ViewBuilder label: @escaping (_ isOpen: Bool) -> Label) {
        self.spaceID = spaceID
        self.coordinator = coordinator
        self.label = label
    }

    public var body: some View {
        Button {
            let actions = ImmersiveSpaceActions(open: openImmersiveSpace, dismiss: dismissImmersiveSpace)
            Task { await coordinator.toggle(spaceID, using: actions) }
        } label: {
            label(coordinator.isOpen(spaceID))
        }
        .disabled(coordinator.isBusy)
    }
}

@available(visionOS 1.0, macOS 26.0, *)
public extension ImmersiveSpaceToggle where Label == SwiftUI.Label<Text, Image> {
    /// Creates a toggle labeled "Show `title`" or "Hide `title`", with a cube icon.
    ///
    /// - Parameters:
    ///   - title: The name of the space, shown in the label.
    ///   - spaceID: The identifier of the `ImmersiveSpace` scene.
    ///   - coordinator: The coordinator that tracks the app's immersive space.
    init(_ title: String, spaceID: String, coordinator: ImmersiveSpaceCoordinator) {
        self.init(spaceID: spaceID, coordinator: coordinator) { isOpen in
            SwiftUI.Label(isOpen ? "Hide \(title)" : "Show \(title)", systemImage: isOpen ? "cube.fill" : "cube.transparent")
        }
    }
}
#endif
