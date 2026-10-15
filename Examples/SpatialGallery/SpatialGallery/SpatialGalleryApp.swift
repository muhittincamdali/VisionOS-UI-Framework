import SwiftUI
import VisionUI

@main
struct SpatialGalleryApp: App {
    @State private var model = GalleryModel()
    @State private var spaces = ImmersiveSpaceCoordinator()

    var body: some Scene {
        WindowGroup(id: "gallery") {
            GalleryView(initialPage: GalleryPage(launchArguments: ProcessInfo.processInfo.arguments))
                .modifier(LaunchArguments(model: model))
                .environment(model)
                .environment(spaces)
                .tint(Palette.blues[0])
        }

        #if os(visionOS)
        WindowGroup(id: "volume") {
            LayoutVolume()
                .environment(model)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 0.8, depth: 1, in: .meters)

        ImmersiveSpace(id: "orbit") {
            OrbitSpace()
                .environment(spaces)
        }
        #endif
    }
}

/// Launch arguments that scripts/capture-gallery.sh uses to set up a screenshot:
/// `-layout <name>` picks a layout and `-spheres` shows spheres in the volume; on visionOS
/// `-open-volume` opens the volume and `-open-immersive` opens the immersive space.
struct LaunchArguments: ViewModifier {
    let model: GalleryModel
    #if os(visionOS)
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(ImmersiveSpaceCoordinator.self) private var spaces
    #endif

    func body(content: Content) -> some View {
        content.task {
            let arguments = ProcessInfo.processInfo.arguments
            if let flag = arguments.firstIndex(of: "-layout"), arguments.indices.contains(flag + 1),
               let kind = LayoutKind(rawValue: arguments[flag + 1]) {
                model.layoutKind = kind
            }
            model.showsSpheres = arguments.contains("-spheres")
            #if os(visionOS)
            if arguments.contains("-open-volume") {
                openWindow(id: "volume")
            }
            if arguments.contains("-open-immersive") {
                await spaces.open("orbit", using: ImmersiveSpaceActions(open: openImmersiveSpace, dismiss: dismissImmersiveSpace))
            }
            #endif
        }
    }
}
