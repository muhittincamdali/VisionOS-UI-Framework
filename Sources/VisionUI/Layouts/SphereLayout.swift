import Foundation
import simd

/// Items spread evenly over a sphere centered on the origin.
///
/// The points follow a Fibonacci spiral from the top of the sphere to the bottom: each item
/// covers about the same area, without the crowding at the poles that rows of latitude give.
/// The order runs from top to bottom, so the first items are the highest.
///
/// ```swift
/// let globe = SphereLayout(radius: 0.3, facing: .outward)
/// ```
public struct SphereLayout: SpatialLayout, Equatable {
    /// The golden angle, `π(3 − √5)`, in radians: the turn between consecutive items.
    public static let goldenAngle: Float = .pi * (3 - sqrt(5))

    /// The radius of the sphere, in meters.
    public var radius: Float
    /// Which way the items face. ``SpatialFacing/forward`` keeps every item facing the viewer.
    public var facing: SpatialFacing

    /// Creates a sphere layout. The radius is clamped to
    /// `0...SpatialLayoutLimits.maximumLength`, and NaN becomes `0`.
    ///
    /// - Parameters:
    ///   - radius: The radius of the sphere, in meters.
    ///   - facing: Which way the items face.
    public init(radius: Float = 0.5, facing: SpatialFacing = .outward) {
        self.radius = radius
        self.facing = facing
    }

    public func placements(count: Int) -> [SpatialPlacement] {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 0 else { return [] }
        let radius = SpatialLayoutLimits.clampedLength(radius, fallback: 0)
        return (0..<count).map { index in
            // Heights are spaced evenly; each is the middle of a band of equal area.
            let height = 1 - 2 * (Float(index) + 0.5) / Float(count)
            let ring = sqrt(max(0, 1 - height * height))
            let angle = Float(index) * Self.goldenAngle
            let unit = SIMD3<Float>(ring * sin(angle), height, ring * cos(angle))
            return SpatialPlacement(position: unit * radius, orientation: facing.orientation(at: unit, around: .zero))
        }
    }
}
