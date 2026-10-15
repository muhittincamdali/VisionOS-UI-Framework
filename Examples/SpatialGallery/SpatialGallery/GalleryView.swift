import SwiftUI
import VisionUI

/// A screen of the gallery.
enum GalleryPage: String, CaseIterable, Identifiable {
    case quickStart = "Quick start"
    case layouts = "Layouts"
    case carousel = "Carousel"
    case manipulation = "Manipulation"
    case components = "Components"
    case realityKit = "RealityKit"
    #if os(visionOS)
    case immersive = "Immersive space"
    #endif

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .quickStart: "sparkles"
        case .layouts: "circle.grid.3x3"
        case .carousel: "rotate.3d"
        case .manipulation: "hand.draw"
        case .components: "square.on.square"
        case .realityKit: "cube"
        #if os(visionOS)
        case .immersive: "globe"
        #endif
        }
    }

    /// The page named by `-page <name>` on the command line, which scripts/capture-gallery.sh uses
    /// to open a screen directly, for example `-page Carousel`.
    init?(launchArguments: [String]) {
        guard let flag = launchArguments.firstIndex(of: "-page"), launchArguments.indices.contains(flag + 1) else {
            return nil
        }
        self.init(rawValue: launchArguments[flag + 1])
    }
}

/// Settings shared by the gallery window and, on visionOS, the volume.
@MainActor
@Observable
final class GalleryModel {
    var layoutKind: LayoutKind = .arc
    var count = 9
    /// Whether the volume shows RealityKit spheres instead of SwiftUI tiles.
    var showsSpheres = false
}

struct GalleryView: View {
    @State private var selection: GalleryPage?

    init(initialPage: GalleryPage? = nil) {
        _selection = State(initialValue: initialPage ?? .quickStart)
    }

    var body: some View {
        NavigationSplitView {
            List(GalleryPage.allCases, selection: $selection) { page in
                Label(page.rawValue, systemImage: page.symbol).tag(page)
            }
            .navigationTitle("VisionUI")
        } detail: {
            if let selection {
                page(selection)
                    .navigationTitle(selection.rawValue)
            } else {
                Text("Choose a page")
            }
        }
    }

    @ViewBuilder
    private func page(_ page: GalleryPage) -> some View {
        switch page {
        case .quickStart: ContentView()
        case .layouts: LayoutsPage()
        case .carousel: CarouselSample()
        case .manipulation: ManipulationPage()
        case .components: ComponentsPage()
        case .realityKit: RealityKitPage()
        #if os(visionOS)
        case .immersive: ImmersivePage()
        #endif
        }
    }
}

/// Picks a layout and an item count, and shows the result.
struct LayoutsPage: View {
    @Environment(GalleryModel.self) private var model
    #if os(visionOS)
    @Environment(\.openWindow) private var openWindow
    #endif

    var body: some View {
        @Bindable var model = model
        VStack(spacing: 24) {
            Picker("Layout", selection: $model.layoutKind) {
                ForEach(LayoutKind.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 480)
            Stepper("\(model.count) items", value: $model.count, in: 1...40)
                .frame(maxWidth: 220)
            Text(model.layoutKind.summary)
                .foregroundStyle(.secondary)
            #if os(visionOS)
            LayoutDiagram(layout: model.layoutKind.layout, count: model.count)
            Button("Show in a volume", systemImage: "cube.transparent") {
                model.showsSpheres = false
                openWindow(id: "volume")
            }
            #else
            SpatialLayoutView(model.layoutKind.layout, Array(0..<model.count), id: \.self) { index in
                Tile(index: index)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.spring(duration: 0.5), value: model.layoutKind)
            #endif
        }
        .padding(32)
    }
}

/// The manipulation sample with a readout of its state.
struct ManipulationPage: View {
    @State private var state = ManipulationState(constraints: ManipulationConstraints(
        bounds: SpatialBounds(center: .zero, size: [0.4, 0.3, 0.2]),
        scaleRange: 0.5...2,
        rotation: .yaw,
        yawSnapAngle: .pi / 4
    ))

    var body: some View {
        VStack(spacing: 24) {
            Text("Drag, pinch or turn the card. It stays inside a 40 × 30 × 20 cm box, scales between 0.5× and 2×, turns only around the vertical axis and snaps to 45°.")
                .multilineTextAlignment(.center)
                .frame(maxWidth: 520)
            Spacer(minLength: 0)
            SpatialCard {
                Label("Move me", systemImage: "hand.draw.fill")
                    .font(.title)
            }
            .spatialManipulation($state)
            Spacer(minLength: 0)
            Text(readout)
                .font(.callout.monospacedDigit())
                .foregroundStyle(.secondary)
            Button("Reset", systemImage: "arrow.counterclockwise") {
                state = ManipulationState(constraints: state.constraints)
            }
        }
        .padding(32)
    }

    private var readout: String {
        let position = state.position
        let yaw = Int((2 * atan2(state.orientation.vector.y, state.orientation.vector.w) * 180 / .pi).rounded())
        return String(format: "x %.2f m · y %.2f m · z %.2f m · scale %.2f× · turn %d°", position.x, position.y, position.z, state.scale, yaw)
    }
}

/// Cards, hit targets and the toolbar ornament.
struct ComponentsPage: View {
    @State private var taps = 0

    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 24) {
                SpatialCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Saturn").font(.title)
                        Text("Sixth planet from the Sun").foregroundStyle(.secondary)
                    }
                }
                SpatialCard(depth: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("With depth").font(.title)
                        Text("24 points in front").foregroundStyle(.secondary)
                    }
                }
            }
            HStack(spacing: 40) {
                Image(systemName: "star.fill")
                    .onTapGesture { taps += 1 }
                    .spatialHitTarget()
                    .overlay {
                        Rectangle()
                            .strokeBorder(.blue.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [4]))
                            .frame(width: HitTarget.platformDefault, height: HitTarget.platformDefault)
                    }
                Text("The star is small, but its dashed area is tappable: \(taps) taps")
                    .foregroundStyle(.secondary)
            }
            PlayerSample()
                .frame(height: 180)
        }
        .padding(32)
    }
}

#if os(visionOS)
struct ImmersivePage: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Opens a space with 60 spheres spread over a sphere around you. Close it with the button or the Digital Crown; the button follows either way.")
                .multilineTextAlignment(.center)
                .frame(maxWidth: 480)
            ImmersiveSample()
        }
        .padding(32)
    }
}
#endif
