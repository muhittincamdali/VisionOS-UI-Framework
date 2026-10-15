import Foundation
import simd

/// Items evenly spaced on a closed horizontal circle, like a carousel seen from the side.
///
/// The circle is centered on the origin. With a `rotation` of zero the first item is at the
/// front, at `(0, 0, radius)`, and the next items follow counterclockwise when seen from above,
/// starting toward `+x`. Increase `rotation` to turn the whole ring; ``SpatialCarousel`` does
/// that from a drag.
///
/// ```swift
/// let ring = RingLayout(radius: 0.4)
/// let front = ring.frontIndex(count: 8)   // 0
/// ```
public struct RingLayout: SpatialLayout, Equatable {
    /// The radius of the circle, in meters.
    public var radius: Float
    /// How far the ring is turned, in radians. Positive values move the items toward `+x`.
    public var rotation: Float
    /// Which way the items face.
    public var facing: SpatialFacing

    /// Creates a ring layout.
    ///
    /// The radius is clamped to `0...SpatialLayoutLimits.maximumLength` (NaN becomes `0`, which
    /// stacks the items at the origin), and a non-finite rotation becomes `0`.
    ///
    /// - Parameters:
    ///   - radius: The radius of the circle, in meters.
    ///   - rotation: How far the ring is turned, in radians.
    ///   - facing: Which way the items face. ``SpatialFacing/outward`` shows their fronts to a
    ///     viewer outside the ring.
    public init(radius: Float = 0.5, rotation: Float = 0, facing: SpatialFacing = .outward) {
        self.radius = radius
        self.rotation = rotation
        self.facing = facing
    }

    /// The largest rotation, in radians, that ``rotation(bringingToFront:count:from:)`` keeps
    /// count of. Beyond it the rotation is first wrapped to one turn.
    public static let maximumTrackedRotation: Float = 100_000

    /// The angle between neighboring items, in radians: `2π / count`, or `0` for no items.
    public static func angleStep(count: Int) -> Float {
        let count = SpatialLayoutLimits.clampedCount(count)
        return count > 0 ? 2 * .pi / Float(count) : 0
    }

    public func placements(count: Int) -> [SpatialPlacement] {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 0 else { return [] }
        let radius = SpatialLayoutLimits.clampedLength(radius, fallback: 0)
        let start = SpatialMath.wrappedAngle(rotation)
        let step = Self.angleStep(count: count)
        return (0..<count).map { index in
            let angle = start + Float(index) * step
            let position = SIMD3<Float>(radius * sin(angle), 0, radius * cos(angle))
            return SpatialPlacement(position: position, orientation: facing.yawOrientation(atAngle: angle))
        }
    }

    /// The index of the item closest to the front of the ring, `(0, 0, radius)`.
    ///
    /// Returns `0` for a count of zero or less. Counts above
    /// ``SpatialLayoutLimits/maximumItemCount`` are clamped to it.
    public func frontIndex(count: Int) -> Int {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 0 else { return 0 }
        let step = Self.angleStep(count: count)
        // Item `i` sits at `rotation + i * step`; it is in front when that angle is a full turn.
        let steps = (-SpatialMath.wrappedAngle(rotation) / step).rounded()
        let index = Int(steps) % count
        return index < 0 ? index + count : index
    }

    /// The rotation that brings item `index` to the front, choosing the one closest to `current`
    /// so that the ring turns the short way round.
    ///
    /// The index wraps around, so `-1` is the last item. `current` may be any number of turns;
    /// the result is within half a step of it. A non-finite `current` is treated as `0`.
    public static func rotation(bringingToFront index: Int, count: Int, from current: Float) -> Float {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 0 else { return 0 }
        var current = SpatialMath.finite(current, or: 0)
        // Far from zero a Float cannot tell neighboring items apart; start again from one turn.
        if abs(current) > maximumTrackedRotation { current = SpatialMath.wrappedAngle(current) }
        let step = angleStep(count: count)
        let wrappedIndex = ((index % count) + count) % count
        let target = -Float(wrappedIndex) * step
        // Shift the target by whole turns so it is as close as possible to `current`.
        let turns = ((current - target) / (2 * .pi)).rounded()
        return target + turns * 2 * .pi
    }

    /// `rotation` rounded to the nearest rotation that puts an item exactly at the front.
    public static func snappedRotation(_ rotation: Float, count: Int) -> Float {
        SpatialMath.snapped(SpatialMath.finite(rotation, or: 0), to: angleStep(count: count))
    }
}
