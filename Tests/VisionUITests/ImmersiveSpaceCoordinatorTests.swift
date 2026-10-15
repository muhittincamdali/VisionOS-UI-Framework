import Testing
@testable import VisionUI

/// Stands in for the system: records calls and can hold an open request until the test releases it.
@MainActor
final class FakeSystem {
    var openRequests: [String] = []
    var dismissCount = 0
    var nextResult: ImmersiveSpaceActions.Result = .opened
    var holdsOpenRequests = false
    private var heldRequest: CheckedContinuation<Void, Never>?

    var actions: ImmersiveSpaceActions {
        ImmersiveSpaceActions(
            open: { [self] id in
                openRequests.append(id)
                if holdsOpenRequests {
                    await withCheckedContinuation { heldRequest = $0 }
                }
                return nextResult
            },
            dismiss: { [self] in dismissCount += 1 }
        )
    }

    var isHoldingRequest: Bool { heldRequest != nil }

    func releaseHeldRequest() {
        heldRequest?.resume()
        heldRequest = nil
    }

    /// Lets the task that called `open` run until the system holds its request.
    func waitForHeldRequest() async {
        for _ in 0..<1_000 where !isHoldingRequest {
            await Task.yield()
        }
    }
}

@MainActor
@Suite("Immersive space coordinator")
struct ImmersiveSpaceCoordinatorTests {
    @Test("opening and dismissing move through the phases")
    func openAndDismiss() async {
        let system = FakeSystem()
        let coordinator = ImmersiveSpaceCoordinator()
        #expect(coordinator.phase == .closed)

        #expect(await coordinator.open("stars", using: system.actions) == .opened)
        #expect(coordinator.phase == .open("stars"))
        #expect(coordinator.openSpaceID == "stars")
        #expect(coordinator.lastOpenResult == .opened)

        #expect(await coordinator.dismiss(using: system.actions))
        #expect(coordinator.phase == .closed)
        #expect(system.openRequests == ["stars"])
        #expect(system.dismissCount == 1)
    }

    @Test("opening the open space again does not call the system")
    func alreadyOpen() async {
        let system = FakeSystem()
        let coordinator = ImmersiveSpaceCoordinator()
        await coordinator.open("stars", using: system.actions)
        #expect(await coordinator.open("stars", using: system.actions) == .alreadyOpen)
        #expect(system.openRequests == ["stars"])
    }

    @Test("opening another space dismisses the open one first")
    func switching() async {
        let system = FakeSystem()
        let coordinator = ImmersiveSpaceCoordinator()
        await coordinator.open("stars", using: system.actions)
        #expect(await coordinator.open("ocean", using: system.actions) == .opened)
        #expect(system.dismissCount == 1)
        #expect(system.openRequests == ["stars", "ocean"])
        #expect(coordinator.phase == .open("ocean"))
    }

    @Test("a request during a transition is refused and changes nothing")
    func busy() async {
        let system = FakeSystem()
        system.holdsOpenRequests = true
        let coordinator = ImmersiveSpaceCoordinator()

        let first = Task { await coordinator.open("stars", using: system.actions) }
        await system.waitForHeldRequest()
        #expect(coordinator.phase == .opening("stars"))
        #expect(coordinator.isBusy)

        #expect(await coordinator.open("ocean", using: system.actions) == .busy)
        #expect(await coordinator.dismiss(using: system.actions) == false)
        #expect(await coordinator.toggle("stars", using: system.actions) == false)
        #expect(system.openRequests == ["stars"])

        system.releaseHeldRequest()
        #expect(await first.value == .opened)
        #expect(coordinator.phase == .open("stars"))
        #expect(!coordinator.isBusy)
    }

    @Test("a cancelled or failed request leaves no space open", arguments: [
        (ImmersiveSpaceActions.Result.userCancelled, ImmersiveSpaceCoordinator.OpenResult.userCancelled),
        (.error, .failed),
    ])
    func unsuccessful(result: ImmersiveSpaceActions.Result, expected: ImmersiveSpaceCoordinator.OpenResult) async {
        let system = FakeSystem()
        system.nextResult = result
        let coordinator = ImmersiveSpaceCoordinator()
        #expect(await coordinator.open("stars", using: system.actions) == expected)
        #expect(coordinator.phase == .closed)
        #expect(coordinator.lastOpenResult == expected)
        // The next request is accepted.
        system.nextResult = .opened
        #expect(await coordinator.open("stars", using: system.actions) == .opened)
    }

    @Test("toggle opens a closed space and dismisses an open one")
    func toggling() async {
        let system = FakeSystem()
        let coordinator = ImmersiveSpaceCoordinator()
        #expect(await coordinator.toggle("stars", using: system.actions))
        #expect(coordinator.isOpen("stars"))
        #expect(await coordinator.toggle("stars", using: system.actions) == false)
        #expect(coordinator.phase == .closed)
        #expect(await coordinator.dismiss(using: system.actions) == false)
        #expect(system.dismissCount == 1)
    }

    @Test("a space closed by the system is recorded as closed")
    func systemDismissal() async {
        let system = FakeSystem()
        let coordinator = ImmersiveSpaceCoordinator()
        await coordinator.open("stars", using: system.actions)

        coordinator.spaceDidDisappear("ocean")
        #expect(coordinator.phase == .open("stars"))

        coordinator.spaceDidDisappear("stars")
        #expect(coordinator.phase == .closed)
        #expect(await coordinator.open("stars", using: system.actions) == .opened)
    }

    @Test("a space that disappears while it opens is reported as not open")
    func disappearsWhileOpening() async {
        let system = FakeSystem()
        system.holdsOpenRequests = true
        let coordinator = ImmersiveSpaceCoordinator()
        let request = Task { await coordinator.open("stars", using: system.actions) }
        await system.waitForHeldRequest()

        coordinator.spaceDidDisappear("stars")
        #expect(coordinator.phase == .closed)

        // A newer request for the same space starts before the old one returns.
        system.holdsOpenRequests = false
        let newer = Task { await coordinator.open("stars", using: system.actions) }
        #expect(await newer.value == .opened)

        system.releaseHeldRequest()
        #expect(await request.value == .failed)
        // The stale request did not undo the newer one.
        #expect(coordinator.phase == .open("stars"))
        #expect(coordinator.lastOpenResult == .opened)
    }
}
