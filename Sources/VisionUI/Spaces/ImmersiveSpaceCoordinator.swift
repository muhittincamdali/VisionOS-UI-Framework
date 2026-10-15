import Observation

/// Tracks the app's immersive space and opens and dismisses it one request at a time.
///
/// An app can show only one immersive space at a time, and opening or dismissing one takes a
/// moment. During that moment a second tap on a button starts a second request, which the system
/// rejects or which leaves the app's own flag out of step with what is on screen. The
/// coordinator keeps a single ``Phase`` and handles the cases around it:
///
/// - A request while another is in progress returns ``OpenResult/busy`` and changes nothing.
/// - Opening a space while a different one is open dismisses the open one first.
/// - Opening the space that is already open returns ``OpenResult/alreadyOpen``.
/// - When the person closes the space from the system (for example with the Digital Crown),
///   call ``spaceDidDisappear(_:)`` from the space's `onDisappear` so the phase follows.
///
/// The coordinator calls the system through ``ImmersiveSpaceActions``, which you build from the
/// environment's `openImmersiveSpace` and `dismissImmersiveSpace`, or from your own closures in
/// tests and previews. ``ImmersiveSpaceToggle`` does that for you.
///
/// ```swift
/// @main
/// struct GalleryApp: App {
///     @State private var spaces = ImmersiveSpaceCoordinator()
///
///     var body: some Scene {
///         WindowGroup {
///             ImmersiveSpaceToggle("Planetarium", spaceID: "planetarium", coordinator: spaces)
///         }
///         ImmersiveSpace(id: "planetarium") {
///             PlanetariumView()
///                 .onDisappear { spaces.spaceDidDisappear("planetarium") }
///         }
///     }
/// }
/// ```
@MainActor
@Observable
public final class ImmersiveSpaceCoordinator {
    /// What the coordinator knows about the immersive space.
    public enum Phase: Sendable, Equatable {
        /// No immersive space is open.
        case closed
        /// The space with this identifier is being opened.
        case opening(String)
        /// The space with this identifier is open.
        case open(String)
        /// The space with this identifier is being dismissed.
        case closing(String)
    }

    /// The result of ``open(_:using:)``.
    public enum OpenResult: Sendable, Equatable {
        /// The space is now open.
        case opened
        /// The space was already open; nothing changed.
        case alreadyOpen
        /// The person declined to open the space.
        case userCancelled
        /// The system could not open the space, for example because no scene has that identifier.
        case failed
        /// Another request was in progress; nothing changed.
        case busy
    }

    /// The current phase.
    public private(set) var phase: Phase = .closed

    /// The result of the last open request that reached the system, or `nil` before the first.
    public private(set) var lastOpenResult: OpenResult?

    /// Counts requests, so a request that finishes after a newer one started does not overwrite it.
    private var generation = 0

    /// Creates a coordinator with no space open.
    public init() {}

    /// The identifier of the open space, or `nil` when none is fully open.
    public var openSpaceID: String? {
        if case .open(let id) = phase { id } else { nil }
    }

    /// Whether a request is in progress.
    public var isBusy: Bool {
        switch phase {
        case .opening, .closing: true
        case .closed, .open: false
        }
    }

    /// Whether the space with `id` is open.
    public func isOpen(_ id: String) -> Bool {
        openSpaceID == id
    }

    /// Opens the space with `id`, first dismissing a different open space.
    ///
    /// - Parameters:
    ///   - id: The identifier of an `ImmersiveSpace` scene in the app.
    ///   - actions: How to call the system.
    /// - Returns: What happened. Only ``OpenResult/opened`` and ``OpenResult/alreadyOpen`` leave
    ///   the space open.
    @discardableResult
    public func open(_ id: String, using actions: ImmersiveSpaceActions) async -> OpenResult {
        switch phase {
        case .opening, .closing:
            return .busy
        case .open(let current) where current == id:
            return .alreadyOpen
        case .open(let current):
            generation &+= 1
            let request = generation
            phase = .closing(current)
            await actions.dismiss()
            guard request == generation, phase == .closing(current) else { return .busy }
        case .closed:
            break
        }
        generation &+= 1
        let request = generation
        phase = .opening(id)
        let result = await actions.open(id)
        // `spaceDidDisappear` may have closed the space, and a newer request may have started,
        // while the system worked.
        guard request == generation, phase == .opening(id) else {
            if request == generation { lastOpenResult = .failed }
            return .failed
        }
        let outcome: OpenResult = switch result {
        case .opened: .opened
        case .userCancelled: .userCancelled
        case .error: .failed
        }
        phase = outcome == .opened ? .open(id) : .closed
        lastOpenResult = outcome
        return outcome
    }

    /// Dismisses the open space.
    ///
    /// - Returns: `true` when a space was open and is now dismissed; `false` when none was open
    ///   or another request was in progress.
    @discardableResult
    public func dismiss(using actions: ImmersiveSpaceActions) async -> Bool {
        guard case .open(let id) = phase else { return false }
        generation &+= 1
        let request = generation
        phase = .closing(id)
        await actions.dismiss()
        if request == generation, phase == .closing(id) { phase = .closed }
        return true
    }

    /// Opens the space with `id` when it is not open, otherwise dismisses it.
    ///
    /// - Returns: `true` when the space is open afterward.
    @discardableResult
    public func toggle(_ id: String, using actions: ImmersiveSpaceActions) async -> Bool {
        if isOpen(id) {
            await dismiss(using: actions)
            return isOpen(id)
        }
        let result = await open(id, using: actions)
        return result == .opened || result == .alreadyOpen
    }

    /// Records that the space with `id` is no longer shown.
    ///
    /// Call it from the root view of the `ImmersiveSpace`, in `onDisappear`. The system closes a
    /// space without asking the app when the person presses the Digital Crown or opens another
    /// app's space. Calls for a space that is not open or opening are ignored.
    public func spaceDidDisappear(_ id: String) {
        switch phase {
        case .open(id), .opening(id): phase = .closed
        default: break
        }
    }
}
