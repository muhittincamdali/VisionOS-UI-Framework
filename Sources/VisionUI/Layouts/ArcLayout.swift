import Foundation
import simd

/// Items on a horizontal arc that bends toward the viewer, like a curved shelf.
///
/// The middle of the arc is at the origin. The arc is part of a circle whose center is `radius`
/// meters in front of it, at `(0, 0, radius)`, so items further from the middle come closer to
/// the viewer and, with ``SpatialFacing/center``, turn to face the circle's center. Put the
/// viewer near that center and every item is at the same distance from them.
///
/// Neighboring items are `spacing` meters apart along the arc. When the items would cover more
/// than `maximumAngle`, the spacing shrinks so that they fit in it.
///
/// ```swift
/// let shelf = ArcLayout(radius: 1.2, spacing: 0.35)
/// let placements = shelf.placements(count: 7)
/// ```
public struct ArcLayout: SpatialLayout, Equatable {
    /// The smallest radius the layout uses, in meters. Smaller values are raised to it.
    public static let minimumRadius: Float = 0.01

    /// The radius of the arc's circle, in meters.
    public var radius: Float
    /// The distance between neighboring items along the arc, in meters.
    public var spacing: Float
    /// The largest angle the items may cover, in radians, from `0` to `2π`.
    public var maximumAngle: Float
    /// Which way the items face.
    public var facing: SpatialFacing

    /// Creates an arc layout.
    ///
    /// Values out of range are corrected when placements are computed: lengths are clamped to
    /// ``minimumRadius`` (radius) or `0` (spacing) and ``SpatialLayoutLimits/maximumLength``, a
    /// NaN radius becomes 1 m and a NaN spacing `0`; the maximum angle is clamped to `0...2π`, and a
    /// non-finite one becomes `π`.
    ///
    /// - Parameters:
    ///   - radius: The radius of the arc's circle, in meters.
    ///   - spacing: The distance between neighboring items along the arc, in meters.
    ///   - maximumAngle: The largest angle the items may cover, in radians.
    ///   - facing: Which way the items face.
    public init(radius: Float = 1, spacing: Float = 0.3, maximumAngle: Float = .pi, facing: SpatialFacing = .center) {
        self.radius = radius
        self.spacing = spacing
        self.maximumAngle = maximumAngle
        self.facing = facing
    }

    /// The radius after correction.
    var effectiveRadius: Float {
        SpatialLayoutLimits.clampedLength(radius, minimum: Self.minimumRadius, fallback: 1)
    }

    /// The angle between neighboring items, in radians, for `count` items.
    public func angleStep(count: Int) -> Float {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 1 else { return 0 }
        let spacing = SpatialLayoutLimits.clampedLength(spacing, fallback: 0)
        let maximum = min(max(SpatialMath.finite(maximumAngle, or: .pi), 0), 2 * .pi)
        return min(spacing / effectiveRadius, maximum / Float(count - 1))
    }

    public func placements(count: Int) -> [SpatialPlacement] {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 0 else { return [] }
        let radius = effectiveRadius
        let step = angleStep(count: count)
        let middle = Float(count - 1) / 2
        return (0..<count).map { index in
            // `theta` is measured at the circle's center, from the middle item toward `+x`.
            let theta = (Float(index) - middle) * step
            let position = SIMD3<Float>(radius * sin(theta), 0, radius * (1 - cos(theta)))
            let orientation: simd_quatf = switch facing {
            case .center: SpatialMath.yawRotation(-theta)
            case .outward: SpatialMath.yawRotation(.pi - theta)
            case .forward: SpatialMath.identity
            }
            return SpatialPlacement(position: position, orientation: orientation)
        }
    }
}
