import SwiftUI
import simd

public extension View {
    /// Lets a person move, resize and turn the view with gestures, within the state's constraints.
    ///
    /// On visionOS a drag moves the view in 3D, a pinch with two hands scales it and a
    /// two-handed turn rotates it; distances are converted between points and meters with the
    /// system's physical metrics, so the state's bounds are real distances in the volume. On iOS
    /// and macOS a drag moves the view on screen, a pinch scales it and a two-finger rotation turns
    /// it around the axis that points at the viewer, with `pointsPerMeter` points for each meter.
    ///
    /// The state is a binding, so you can read it, save it, or reset it from outside.
    ///
    /// ```swift
    /// @State private var globe = ManipulationState(constraints: .init(
    ///     bounds: SpatialBounds(center: .zero, size: [0.6, 0.4, 0.6]),
    ///     rotation: .yaw
    /// ))
    ///
    /// var body: some View {
    ///     Model3D(named: "Globe")
    ///         .spatialManipulation($globe)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - state: The position, scale and orientation, with their constraints.
    ///   - pointsPerMeter: On iOS and macOS, how many points on screen stand for one meter. Ignored
    ///     on visionOS. Values that are not positive and finite are replaced by `1000`.
    func spatialManipulation(_ state: Binding<ManipulationState>, pointsPerMeter: CGFloat = 1000) -> some View {
        modifier(SpatialManipulationModifier(state: state, pointsPerMeter: pointsPerMeter))
    }
}

struct SpatialManipulationModifier: ViewModifier {
    @Binding var state: ManipulationState
    let pointsPerMeter: CGFloat

    #if os(visionOS)
    @Environment(\.physicalMetrics) private var physicalMetrics

    func body(content: Content) -> some View {
        let perMeter = physicalMetrics.convert(1, from: .meters)
        let position = state.position
        let rotation = SpatialUnits.flippingY(state.orientation)
        content
            .scaleEffect(x: CGFloat(state.scale), y: CGFloat(state.scale), z: CGFloat(state.scale))
            .rotation3DEffect(Rotation3D(simd_quatd(vector: SIMD4<Double>(rotation.vector))))
            .offset(x: CGFloat(position.x) * perMeter, y: -CGFloat(position.y) * perMeter)
            .offset(z: CGFloat(position.z) * perMeter)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let translation = value.translation3D
                        state.drag(translation: SpatialUnits.meters(
                            fromPoints: translation.x, translation.y, translation.z,
                            pointsPerMeter: Double(perMeter)
                        ))
                    }
                    .onEnded { _ in state.endDrag() }
            )
            .simultaneousGesture(
                MagnifyGesture()
                    .onChanged { value in state.magnify(by: Float(value.magnification)) }
                    .onEnded { _ in state.endMagnify() }
            )
            .simultaneousGesture(
                RotateGesture3D()
                    .onChanged { value in
                        let quaternion = simd_quatf(vector: SIMD4<Float>(value.rotation.quaternion.vector))
                        state.rotate(by: SpatialUnits.flippingY(quaternion))
                    }
                    .onEnded { _ in state.endRotation() }
            )
    }
    #else
    func body(content: Content) -> some View {
        let perMeter = SpatialUnits.pointsPerMeter(pointsPerMeter)
        let position = state.position
        content
            .scaleEffect(CGFloat(state.scale))
            .rotationEffect(.radians(Double(-rollAngle)))
            .offset(x: CGFloat(position.x) * perMeter, y: -CGFloat(position.y) * perMeter)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        state.drag(translation: SpatialUnits.meters(
                            fromPoints: value.translation.width, value.translation.height, 0,
                            pointsPerMeter: Double(perMeter)
                        ))
                    }
                    .onEnded { _ in state.endDrag() }
            )
            .simultaneousGesture(
                MagnifyGesture()
                    .onChanged { value in state.magnify(by: Float(value.magnification)) }
                    .onEnded { _ in state.endMagnify() }
            )
            .simultaneousGesture(
                RotateGesture()
                    .onChanged { value in
                        // Clockwise on screen is a negative turn around +z, which points at the viewer.
                        state.rotate(by: simd_quatf(angle: -Float(value.rotation.radians), axis: [0, 0, 1]))
                    }
                    .onEnded { _ in state.endRotation() }
            )
    }

    /// The turn around `+z`, the axis that points at the viewer, in radians.
    private var rollAngle: Float {
        let vector = state.orientation.vector
        guard abs(vector.z) + abs(vector.w) > 1e-6 else { return 0 }
        return 2 * atan2(vector.z, vector.w)
    }
    #endif
}
