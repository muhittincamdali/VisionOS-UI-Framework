import RealityKit
import SwiftUI
import VisionUI

/// Spheres arranged with the selected layout; the arrangement animates when the layout changes.
struct LayoutEntities: View {
    let kind: LayoutKind
    let count: Int

    @State private var root = Entity()

    var body: some View {
        RealityView { content in
            content.add(root)
            rebuild()
        } update: { _ in
            rebuild()
        }
    }

    private func rebuild() {
        while root.children.count < count {
            let index = root.children.count
            let sphere = ModelEntity(
                mesh: .generateSphere(radius: 0.025),
                materials: [SimpleMaterial(color: Self.color(index), roughness: 0.3, isMetallic: false)]
            )
            root.addChild(sphere)
        }
        while root.children.count > count, let last = Array(root.children).last {
            last.removeFromParent()
        }
        root.arrangeChildren(using: kind.layout, duration: root.scene == nil ? 0 : 0.6)
    }

    private static func color(_ index: Int) -> SimpleMaterial.Color {
        let blues: [(Double, Double, Double)] = [(0, 0.443, 0.890), (0.039, 0.518, 1), (0, 0.345, 0.831), (0.353, 0.784, 0.980), (0.392, 0.824, 1)]
        let blue = blues[index % blues.count]
        return SimpleMaterial.Color(red: blue.0, green: blue.1, blue: blue.2, alpha: 1)
    }
}

/// The RealityKit page: on visionOS it opens the volume; on iOS and macOS it shows the entities
/// with orbiting camera controls.
struct RealityKitPage: View {
    @Environment(GalleryModel.self) private var model
    #if os(visionOS)
    @Environment(\.openWindow) private var openWindow
    #endif

    var body: some View {
        @Bindable var model = model
        VStack(spacing: 16) {
            Picker("Layout", selection: $model.layoutKind) {
                ForEach(LayoutKind.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 480)
            Text("`Entity.arrangeChildren(using:duration:)` places the spheres and animates them to the new layout.")
                .foregroundStyle(.secondary)
            #if os(visionOS)
            Button("Show in a volume", systemImage: "cube.transparent") {
                model.showsSpheres = true
                openWindow(id: "volume")
            }
            #else
            LayoutEntities(kind: model.layoutKind, count: model.count)
                .realityViewCameraControls(.orbit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            #endif
        }
        .padding(32)
    }
}

#if os(visionOS)
/// The volume: the selected layout with real depth, as SwiftUI tiles or as RealityKit spheres.
struct LayoutVolume: View {
    @Environment(GalleryModel.self) private var model

    var body: some View {
        ZStack {
            if model.showsSpheres {
                LayoutEntities(kind: model.layoutKind, count: model.count)
            } else {
                SpatialLayoutView(model.layoutKind.layout, Array(0..<model.count), id: \.self) { index in
                    Tile(index: index, side: 120)
                }
                .animation(.spring(duration: 0.6), value: model.layoutKind)
            }
        }
        .toolbarOrnament(edge: .bottom) {
            ForEach(LayoutKind.allCases) { kind in
                Button(kind.rawValue, systemImage: model.layoutKind == kind ? "\(index(of: kind)).circle.fill" : "\(index(of: kind)).circle") {
                    model.layoutKind = kind
                }
            }
            Button(model.showsSpheres ? "Show tiles" : "Show spheres", systemImage: model.showsSpheres ? "square.grid.2x2" : "circle.grid.cross") {
                model.showsSpheres.toggle()
            }
        }
    }

    private func index(of kind: LayoutKind) -> Int {
        (LayoutKind.allCases.firstIndex(of: kind) ?? 0) + 1
    }
}

/// The immersive space: spheres spread over a sphere around the person, at eye height.
struct OrbitSpace: View {
    @Environment(ImmersiveSpaceCoordinator.self) private var spaces

    var body: some View {
        RealityView { content in
            let orbit = Entity()
            orbit.position = [0, 1.4, 0]
            for index in 0..<60 {
                let sphere = ModelEntity(
                    mesh: .generateSphere(radius: 0.05),
                    materials: [SimpleMaterial(color: index.isMultiple(of: 2) ? .systemBlue : .systemTeal, isMetallic: false)]
                )
                orbit.addChild(sphere)
            }
            orbit.arrangeChildren(using: .sphere(radius: 1.6, facing: .center))
            content.add(orbit)
        }
        .onDisappear { spaces.spaceDidDisappear("orbit") }
    }
}
#endif
