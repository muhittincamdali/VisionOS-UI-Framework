import SwiftUI

/// The calls ``ImmersiveSpaceCoordinator`` makes to open and dismiss a space.
///
/// On visionOS (and macOS 26 and later) build it from the environment:
///
/// ```swift
/// @Environment(\.openImmersiveSpace) private var openImmersiveSpace
/// @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
///
/// let actions = ImmersiveSpaceActions(open: openImmersiveSpace, dismiss: dismissImmersiveSpace)
/// ```
///
/// In tests and previews, pass closures instead.
public struct ImmersiveSpaceActions: Sendable {
    /// What the system reports after an open request.
    public enum Result: Sendable, Equatable {
        /// The space opened.
        case opened
        /// The person declined.
        case userCancelled
        /// The space could not be opened.
        case error
    }

    /// Opens the space with the given identifier.
    public var open: @MainActor @Sendable (String) async -> Result
    /// Dismisses the open space.
    public var dismiss: @MainActor @Sendable () async -> Void

    /// Creates actions from closures.
    ///
    /// - Parameters:
    ///   - open: Opens the space with the given identifier and reports the result.
    ///   - dismiss: Dismisses the open space and returns when it is gone.
    public init(
        open: @escaping @MainActor @Sendable (String) async -> Result,
        dismiss: @escaping @MainActor @Sendable () async -> Void
    ) {
        self.open = open
        self.dismiss = dismiss
    }
}

#if os(visionOS) || os(macOS)
@available(visionOS 1.0, macOS 26.0, *)
public extension ImmersiveSpaceActions {
    /// Creates actions that call the environment's `openImmersiveSpace` and
    /// `dismissImmersiveSpace`.
    init(open: OpenImmersiveSpaceAction, dismiss: DismissImmersiveSpaceAction) {
        self.init(
            open: { id in
                switch await open(id: id) {
                case .opened: .opened
                case .userCancelled: .userCancelled
                case .error: .error
                @unknown default: .error
                }
            },
            dismiss: { await dismiss() }
        )
    }
}
#endif
