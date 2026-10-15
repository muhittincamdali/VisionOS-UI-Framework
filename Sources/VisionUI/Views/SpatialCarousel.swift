import SwiftUI

/// A ring of views that a person turns with a drag, stopping with one view at the front.
///
/// The views are placed with a ``RingLayout`` facing outward. A horizontal drag turns the ring
/// by the distance dragged along its front; when the drag ends, the ring settles on the nearest
/// view and `selection` becomes its index. Tapping a view, or setting `selection`, turns that view
/// to the front the short way round. VoiceOver users swipe up and down to step through the views.
///
/// On visionOS the ring has real depth. It is centered on the carousel's plane, because a window
/// shows nothing behind its plane: the views at the sides stay visible and the front view comes
/// forward by the radius, so leave some space around the carousel. On iOS and macOS the ring is
/// drawn with ``FlatProjection`` and moved back by its radius, so the front view keeps its own
/// size and the others get smaller toward the back.
///
/// ```swift
/// struct Destinations: View {
///     @State private var selection = 0
///     let places: [Place]
///
///     var body: some View {
///         SpatialCarousel(places, selection: $selection, radius: 0.35) { place in
///             PlaceCard(place)
///         }
///     }
/// }
/// ```
public struct SpatialCarousel<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    @Binding private var selection: Int
    @State private var rotation: Float = 0
    @State private var dragStartRotation: Float?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    #if os(visionOS)
    @Environment(\.physicalMetrics) private var physicalMetrics
    #endif

    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let radius: Float
    private let projection: FlatProjection
    private let content: (Data.Element) -> Content

    /// Creates a carousel.
    ///
    /// - Parameters:
    ///   - data: The elements, one view each.
    ///   - id: The key path to a stable identity for each element.
    ///   - selection: The index of the view at the front. Out-of-range values wrap around.
    ///   - radius: The radius of the ring, in meters.
    ///   - projection: How to draw the ring on iOS and macOS. Ignored on visionOS.
    ///   - content: The view for an element.
    public init(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        selection: Binding<Int>,
        radius: Float = 0.4,
        projection: FlatProjection = FlatProjection(),
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self._selection = selection
        self.radius = radius
        self.projection = projection
        self.content = content
    }

    private var count: Int { SpatialLayoutLimits.clampedCount(data.count) }

    public var body: some View {
        let items = data.prefix(SpatialLayoutLimits.maximumItemCount).enumerated().map { Item(index: $0.offset, element: $0.element) }
        let ring = RingLayout(radius: radius, rotation: rotation).offset([0, 0, depthOffset])
        SpatialLayoutView(ring, items, id: (\Item.element).appending(path: id), projection: projection) { item in
            content(item.element)
                .onTapGesture { turn(to: item.index) }
        }
        .contentShape(Rectangle())
        .gesture(dragGesture)
        .onAppear { rotation = RingLayout.rotation(bringingToFront: selection, count: count, from: 0) }
        .onChange(of: selection) { _, newValue in turn(to: newValue) }
        .accessibilityElement(children: .contain)
        .accessibilityValue(count > 0 ? "\(Self.wrapped(selection, count: count) + 1) of \(count)" : "")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: selection = Self.stepped(selection, by: 1, count: count)
            case .decrement: selection = Self.stepped(selection, by: -1, count: count)
            @unknown default: break
            }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let start = dragStartRotation ?? rotation
                dragStartRotation = start
                rotation = Self.rotation(from: start, dragged: value.translation.width, radiusInPoints: radiusInPoints)
            }
            .onEnded { _ in
                dragStartRotation = nil
                let settled = RingLayout.snappedRotation(rotation, count: count)
                withAnimation(reduceMotion ? nil : .spring(duration: 0.4)) { rotation = settled }
                selection = RingLayout(rotation: settled).frontIndex(count: count)
            }
    }

    /// How far the ring is moved toward the viewer, in meters.
    ///
    /// On iOS and macOS the ring's center sits a radius behind the carousel, so the front view is
    /// in the carousel's plane and drawn at its own size. A visionOS window shows nothing behind
    /// its plane, so there the ring stays centered: the views at the sides remain visible and the
    /// front view comes forward by the radius.
    private var depthOffset: Float {
        #if os(visionOS)
        0
        #else
        -ringRadius
        #endif
    }

    /// The radius the ring layout uses after its own correction.
    private var ringRadius: Float {
        SpatialLayoutLimits.clampedLength(radius, fallback: 0)
    }

    private var radiusInPoints: CGFloat {
        #if os(visionOS)
        CGFloat(ringRadius) * physicalMetrics.convert(1, from: .meters)
        #else
        CGFloat(ringRadius) * SpatialUnits.pointsPerMeter(projection.pointsPerMeter)
        #endif
    }

    private func turn(to index: Int) {
        guard count > 0 else { return }
        let target = RingLayout.rotation(bringingToFront: index, count: count, from: rotation)
        withAnimation(reduceMotion ? nil : .spring(duration: 0.5)) { rotation = target }
        let wrapped = Self.wrapped(index, count: count)
        if selection != wrapped { selection = wrapped }
    }

    /// The ring's rotation after a horizontal drag of `distance` points that started at `start`.
    ///
    /// The front of the ring follows the finger: a drag the length of the radius turns the ring
    /// by one radian. A radius that is not positive, or values that are not finite, leave `start`.
    nonisolated static func rotation(from start: Float, dragged distance: CGFloat, radiusInPoints: CGFloat) -> Float {
        guard start.isFinite, distance.isFinite, radiusInPoints.isFinite, radiusInPoints > 1e-3 else {
            return start.isFinite ? start : 0
        }
        let turned = start + Float(distance / radiusInPoints)
        return turned.isFinite ? turned : start
    }

    private struct Item {
        let index: Int
        let element: Data.Element
    }

    /// The index `delta` steps from `index`, wrapped into `0..<count`.
    ///
    /// The index is wrapped before the step, so `Int.max` steps to a valid index instead of
    /// overflowing.
    nonisolated static func stepped(_ index: Int, by delta: Int, count: Int) -> Int {
        guard count > 0 else { return 0 }
        return wrapped(wrapped(index, count: count) + wrapped(delta, count: count), count: count)
    }

    /// `index` wrapped into `0..<count`; `0` when the count is zero or less.
    nonisolated static func wrapped(_ index: Int, count: Int) -> Int {
        guard count > 0 else { return 0 }
        let remainder = index % count
        return remainder < 0 ? remainder + count : remainder
    }
}

public extension SpatialCarousel where Data.Element: Identifiable, ID == Data.Element.ID {
    /// Creates a carousel from identifiable elements.
    ///
    /// - Parameters:
    ///   - data: The elements, one view each.
    ///   - selection: The index of the view at the front. Out-of-range values wrap around.
    ///   - radius: The radius of the ring, in meters.
    ///   - projection: How to draw the ring on iOS and macOS. Ignored on visionOS.
    ///   - content: The view for an element.
    init(
        _ data: Data,
        selection: Binding<Int>,
        radius: Float = 0.4,
        projection: FlatProjection = FlatProjection(),
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.init(data, id: \.id, selection: selection, radius: radius, projection: projection, content: content)
    }
}
