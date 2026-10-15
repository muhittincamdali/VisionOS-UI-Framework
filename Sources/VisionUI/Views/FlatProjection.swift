import CoreGraphics
import simd

/// How ``SpatialLayoutView`` and ``SpatialCarousel`` draw a 3D placement on a flat screen
/// (iOS and macOS), where views have no depth.
///
/// The placement is seen from the front, from `viewerDistance` meters in front of the origin:
/// its `x` and `y` become an offset in points, items closer to the viewer are drawn larger and
/// on top, and items further away smaller and below. On visionOS the views are placed in real
/// depth instead and this projection is not used.
public struct FlatProjection: Sendable, Equatable {
    /// The smallest and largest scale the projection gives an item.
    public static let scaleRange: ClosedRange<CGFloat> = 0.2...3

    /// How many points stand for one meter.
    public var pointsPerMeter: CGFloat
    /// The distance from the viewer to the origin, in meters. Larger values flatten the depth.
    public var viewerDistance: Float

    /// Creates a projection.
    ///
    /// - Parameters:
    ///   - pointsPerMeter: How many points stand for one meter. Values that are not positive and
    ///     finite become `1000`, and values above `1_000_000` become `1_000_000`.
    ///   - viewerDistance: The distance from the viewer to the origin, in meters. Values that are
    ///     not positive and finite become `1.5`.
    public init(pointsPerMeter: CGFloat = 1000, viewerDistance: Float = 1.5) {
        self.pointsPerMeter = pointsPerMeter
        self.viewerDistance = viewerDistance
    }

    /// Where and how large to draw an item.
    public struct Projected: Sendable, Equatable {
        /// The offset from the center of the container, in points, `+y` down.
        public var offset: CGSize
        /// The scale for the item's depth.
        public var scale: CGFloat
        /// The drawing order: higher values are drawn on top.
        public var zIndex: Double
        /// The item's turn around the vertical axis, in radians, for a 3D rotation effect.
        public var yaw: Double
    }

    /// Projects a placement.
    public func project(_ placement: SpatialPlacement) -> Projected {
        let perMeter = SpatialUnits.pointsPerMeter(pointsPerMeter)
        let distance = viewerDistance.isFinite && viewerDistance > 0 ? viewerDistance : 1.5
        let position = SpatialMath.finite(placement.position, or: .zero)
        // Perspective: an item `z` meters closer than the origin is `distance / (distance - z)` as large.
        let depth = max(distance - position.z, 1e-3)
        let scale = min(max(CGFloat(distance / depth), Self.scaleRange.lowerBound), Self.scaleRange.upperBound)
        let limit = Double(SpatialLayoutLimits.maximumLength) * Double(perMeter)
        let x = min(max(Double(position.x) * Double(perMeter), -limit), limit)
        let y = min(max(-Double(position.y) * Double(perMeter), -limit), limit)
        return Projected(
            offset: CGSize(width: x, height: y),
            scale: scale,
            zIndex: Double(position.z),
            yaw: Double(placement.yaw)
        )
    }
}
