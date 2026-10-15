import simd

/// An axis-aligned box, in meters, that keeps a position inside it.
public struct SpatialBounds: Sendable, Equatable {
    /// The corner with the smallest coordinates.
    public let min: SIMD3<Float>
    /// The corner with the largest coordinates.
    public let max: SIMD3<Float>

    /// Creates a box from two opposite corners, given in any order.
    ///
    /// Each axis is sorted, so `min` is never above `max`. Coordinates are clamped to
    /// ±``SpatialLayoutLimits/maximumLength``, so pass `.infinity` for an axis without a limit;
    /// a NaN coordinate becomes `0`.
    public init(min first: SIMD3<Float>, max second: SIMD3<Float>) {
        let first = Self.sanitized(first)
        let second = Self.sanitized(second)
        self.min = simd_min(first, second)
        self.max = simd_max(first, second)
    }

    /// Creates a box from its center and its size.
    ///
    /// A negative size component is used as its magnitude.
    public init(center: SIMD3<Float>, size: SIMD3<Float>) {
        let half = simd_abs(Self.sanitized(size)) / 2
        let center = Self.sanitized(center)
        self.init(min: center - half, max: center + half)
    }

    /// The center of the box.
    public var center: SIMD3<Float> { (min + max) / 2 }

    /// The size of the box on each axis.
    public var size: SIMD3<Float> { max - min }

    /// Whether `point` is inside the box or on its surface.
    public func contains(_ point: SIMD3<Float>) -> Bool {
        all(point .>= min) && all(point .<= max)
    }

    /// The point inside the box closest to `point`. NaN coordinates become the box's center.
    public func clamp(_ point: SIMD3<Float>) -> SIMD3<Float> {
        let point = SIMD3<Float>(
            point.x.isNaN ? center.x : point.x,
            point.y.isNaN ? center.y : point.y,
            point.z.isNaN ? center.z : point.z
        )
        return simd_clamp(point, min, max)
    }

    private static func sanitized(_ vector: SIMD3<Float>) -> SIMD3<Float> {
        let limit = SIMD3<Float>(repeating: SpatialLayoutLimits.maximumLength)
        return simd_clamp(vector.replacing(with: 0, where: vector .!= vector), -limit, limit)
    }
}
