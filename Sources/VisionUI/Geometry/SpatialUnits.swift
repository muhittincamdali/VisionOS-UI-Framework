import CoreGraphics
import simd

/// Converts between the package's meters (`+y` up) and SwiftUI's points (`+y` down).
enum SpatialUnits {
    static let defaultPointsPerMeter: CGFloat = 1000
    /// One point per micrometer. With positions of up to ±``SpatialLayoutLimits/maximumLength``
    /// this keeps offsets within ±1e10 points, far from overflowing.
    static let maximumPointsPerMeter: CGFloat = 1_000_000

    /// `value` when it is positive and finite, at most ``maximumPointsPerMeter``; otherwise
    /// ``defaultPointsPerMeter``.
    static func pointsPerMeter(_ value: CGFloat) -> CGFloat {
        value.isFinite && value > 0 ? min(value, maximumPointsPerMeter) : defaultPointsPerMeter
    }

    /// A translation in SwiftUI points, `+y` down, as meters with `+y` up.
    static func meters(fromPoints x: Double, _ y: Double, _ z: Double, pointsPerMeter: Double) -> SIMD3<Float> {
        SIMD3<Float>(Float(x / pointsPerMeter), Float(-y / pointsPerMeter), Float(z / pointsPerMeter))
    }

    /// A rotation in the package's space (`+y` up) as the same rotation in SwiftUI's space
    /// (`+y` down), or the reverse: flipping `y` maps the quaternion `(x, y, z, w)` to
    /// `(-x, y, -z, w)`, and doing it twice gives the original.
    static func flippingY(_ rotation: simd_quatf) -> simd_quatf {
        let vector = rotation.vector
        return simd_quatf(vector: SIMD4<Float>(-vector.x, vector.y, -vector.z, vector.w))
    }
}
