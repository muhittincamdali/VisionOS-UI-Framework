import Foundation
import simd

/// Items on a spiral that rises around the vertical axis, centered on the origin.
///
/// Each item is `rise` meters above the one before and turned by `2π / itemsPerTurn` around the
/// axis. The first item is at the bottom, in front of the axis; the whole spiral is centered
/// vertically on the origin.
///
/// ```swift
/// let timeline = HelixLayout(radius: 0.45, rise: 0.04, itemsPerTurn: 10)
/// ```
public struct HelixLayout: SpatialLayout, Equatable {
    /// The smallest number of items per turn the layout uses. Smaller values are raised to it.
    public static let minimumItemsPerTurn: Float = 1

    /// The distance from the axis, in meters.
    public var radius: Float
    /// The height between consecutive items, in meters. Negative values make the spiral descend.
    public var rise: Float
    /// How many items make one full turn.
    public var itemsPerTurn: Float
    /// Which way the items face.
    public var facing: SpatialFacing

    /// Creates a helix layout.
    ///
    /// The radius is clamped to `0...SpatialLayoutLimits.maximumLength` and the rise to the same
    /// length either way; NaN becomes `0` for both. Items per turn that are NaN or below
    /// ``minimumItemsPerTurn`` become that minimum.
    ///
    /// - Parameters:
    ///   - radius: The distance from the axis, in meters.
    ///   - rise: The height between consecutive items, in meters.
    ///   - itemsPerTurn: How many items make one full turn.
    ///   - facing: Which way the items face.
    public init(radius: Float = 0.5, rise: Float = 0.05, itemsPerTurn: Float = 8, facing: SpatialFacing = .outward) {
        self.radius = radius
        self.rise = rise
        self.itemsPerTurn = itemsPerTurn
        self.facing = facing
    }

    public func placements(count: Int) -> [SpatialPlacement] {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 0 else { return [] }
        let radius = SpatialLayoutLimits.clampedLength(radius, fallback: 0)
        let maximumRise = SpatialLayoutLimits.maximumLength
        let rise = rise.isNaN ? 0 : min(max(rise, -maximumRise), maximumRise)
        let perTurn = itemsPerTurn.isNaN ? Self.minimumItemsPerTurn : max(itemsPerTurn, Self.minimumItemsPerTurn)
        let step = 2 * .pi / perTurn
        let middle = Float(count - 1) / 2
        return (0..<count).map { index in
            let angle = Float(index) * step
            let height = (Float(index) - middle) * rise
            let position = SIMD3<Float>(radius * sin(angle), height, radius * cos(angle))
            return SpatialPlacement(position: position, orientation: facing.yawOrientation(atAngle: angle))
        }
    }
}
