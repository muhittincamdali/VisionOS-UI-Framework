import SwiftUI
import simd

/// A container that places one view per element of a collection with a ``SpatialLayout``.
///
/// On visionOS each view is moved and turned in real depth, with distances converted from
/// meters to points by the system, so a ``ArcLayout`` with a radius of 1 m curves around a
/// person standing 1 m away. On iOS and macOS the same layout is drawn as seen from the front
/// with ``FlatProjection``: nearer views larger and on top.
///
/// ```swift
/// struct Shelf: View {
///     let albums: [Album]
///
///     var body: some View {
///         SpatialLayoutView(.arc(radius: 0.8, spacing: 0.22), albums) { album in
///             AlbumCover(album)
///                 .frame(width: 180, height: 180)
///         }
///     }
/// }
/// ```
///
/// Elements beyond ``SpatialLayoutLimits/maximumItemCount`` are not shown.
public struct SpatialLayoutView<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    private let layout: any SpatialLayout
    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let projection: FlatProjection
    private let content: (Data.Element) -> Content

    /// Creates a container from a collection and a key path to each element's identity.
    ///
    /// - Parameters:
    ///   - layout: The layout that places the views.
    ///   - data: The elements, one view each, in layout order.
    ///   - id: The key path to a stable identity for each element.
    ///   - projection: How to draw the layout on iOS and macOS. Ignored on visionOS.
    ///   - content: The view for an element.
    public init(
        _ layout: some SpatialLayout,
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        projection: FlatProjection = FlatProjection(),
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.layout = layout
        self.data = data
        self.id = id
        self.projection = projection
        self.content = content
    }

    public var body: some View {
        let elements = Array(data.prefix(SpatialLayoutLimits.maximumItemCount))
        let placements = layout.placements(count: elements.count)
        let entries = zip(elements, placements).map { element, placement in
            Entry(id: element[keyPath: id], element: element, placement: placement)
        }
        ZStack {
            ForEach(entries) { entry in
                content(entry.element)
                    .modifier(SpatialPlacementEffect(placement: entry.placement, projection: projection))
            }
        }
    }

    private struct Entry: Identifiable {
        let id: ID
        let element: Data.Element
        let placement: SpatialPlacement
    }
}

public extension SpatialLayoutView where Data.Element: Identifiable, ID == Data.Element.ID {
    /// Creates a container from a collection of identifiable elements.
    ///
    /// - Parameters:
    ///   - layout: The layout that places the views.
    ///   - data: The elements, one view each, in layout order.
    ///   - projection: How to draw the layout on iOS and macOS. Ignored on visionOS.
    ///   - content: The view for an element.
    init(
        _ layout: some SpatialLayout,
        _ data: Data,
        projection: FlatProjection = FlatProjection(),
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.init(layout, data, id: \.id, projection: projection, content: content)
    }
}

public extension View {
    /// Moves and turns the view to a placement.
    ///
    /// On visionOS the view moves in depth and turns in 3D, with meters converted to points by
    /// the system. On iOS and macOS it is drawn with `projection`, as seen from the front.
    func spatialPlacement(_ placement: SpatialPlacement, projection: FlatProjection = FlatProjection()) -> some View {
        modifier(SpatialPlacementEffect(placement: placement, projection: projection))
    }
}

/// Applies one placement to a view.
struct SpatialPlacementEffect: ViewModifier {
    let placement: SpatialPlacement
    let projection: FlatProjection

    #if os(visionOS)
    @Environment(\.physicalMetrics) private var physicalMetrics

    func body(content: Content) -> some View {
        let perMeter = physicalMetrics.convert(1, from: .meters)
        let placement = placement.sanitized
        let position = placement.position
        let rotation = SpatialUnits.flippingY(placement.orientation).vector
        content
            .rotation3DEffect(Rotation3D(simd_quatd(vector: SIMD4<Double>(rotation))))
            .offset(x: CGFloat(position.x) * perMeter, y: -CGFloat(position.y) * perMeter)
            .offset(z: CGFloat(position.z) * perMeter)
    }
    #else
    func body(content: Content) -> some View {
        let projected = projection.project(placement.sanitized)
        content
            .rotation3DEffect(.radians(projected.yaw), axis: (x: 0, y: 1, z: 0), perspective: 0.4)
            .scaleEffect(projected.scale)
            .offset(projected.offset)
            .zIndex(projected.zIndex)
    }
    #endif
}
