import simd

/// A rule that places a number of items in 3D space.
///
/// A layout returns one ``SpatialPlacement`` per item, in meters, around its own origin. Use the
/// placements with ``SpatialLayoutView`` for SwiftUI views, with
/// `Entity.arrangeChildren(using:)` for RealityKit entities, or read them directly.
///
/// The package includes five layouts:
///
/// | Layout | Shape | Typical use |
/// | --- | --- | --- |
/// | ``ArcLayout`` | Items on a curve that bends toward the viewer | Shelves and galleries in a volume |
/// | ``RingLayout`` | A closed circle | Carousels |
/// | ``GridLayout`` | Columns, rows and layers | Libraries and inventories |
/// | ``SphereLayout`` | Evenly spread over a sphere | Globes and point clouds |
/// | ``HelixLayout`` | A rising spiral | Timelines |
///
/// Write your own by returning placements from ``placements(count:)``; use
/// ``SpatialLayoutLimits/clampedCount(_:)`` to keep the count in range.
public protocol SpatialLayout: Sendable {
    /// The placements for `count` items, in order.
    ///
    /// Implementations return an empty array for a count of zero or less, and at most
    /// ``SpatialLayoutLimits/maximumItemCount`` placements.
    func placements(count: Int) -> [SpatialPlacement]
}

/// Bounds that keep layouts from allocating unbounded memory.
public enum SpatialLayoutLimits {
    /// The largest number of placements a layout returns. Items beyond it are not placed.
    ///
    /// The limit protects an app from a count read from a file or a server: a layout allocates
    /// one placement per item, so a count of `Int.max` would otherwise exhaust memory.
    public static let maximumItemCount = 4_096

    /// The largest distance, in meters, that a layout accepts for a radius, a spacing or a rise.
    /// Larger values are lowered to it, so positions stay finite for every item count.
    public static let maximumLength: Float = 10_000

    /// A length clamped to `minimum...maximumLength`, with `fallback` for NaN.
    ///
    /// Infinity is treated as the largest length, and negative infinity as `minimum`.
    @inlinable
    public static func clampedLength(_ value: Float, minimum: Float = 0, fallback: Float) -> Float {
        guard !value.isNaN else { return fallback }
        return min(max(value, minimum), maximumLength)
    }

    /// `count` clamped to `0...maximumItemCount`.
    @inlinable
    public static func clampedCount(_ count: Int) -> Int {
        min(max(count, 0), maximumItemCount)
    }
}

/// Which way the items of a curved layout face.
public enum SpatialFacing: Sendable, Equatable, CaseIterable {
    /// Every item faces the center of its curve.
    case center
    /// Every item faces away from the center of its curve.
    case outward
    /// Every item faces `+z`, toward the viewer, whatever its position.
    case forward
}

extension SpatialFacing {
    /// The orientation for an item at `position` on a curve around `center`.
    func orientation(at position: SIMD3<Float>, around center: SIMD3<Float>) -> simd_quatf {
        switch self {
        case .center: SpatialMath.facing(center - position)
        case .outward: SpatialMath.facing(position - center)
        case .forward: SpatialMath.identity
        }
    }

    /// The orientation for an item on a horizontal circle, from its angle on the circle.
    ///
    /// `angle` is measured from `+z` toward `+x`, so the outward direction of the item is
    /// `(sin angle, 0, cos angle)`.
    func yawOrientation(atAngle angle: Float) -> simd_quatf {
        switch self {
        case .center: SpatialMath.yawRotation(angle + .pi)
        case .outward: SpatialMath.yawRotation(angle)
        case .forward: SpatialMath.identity
        }
    }
}

public extension SpatialLayout where Self == ArcLayout {
    /// Items on a horizontal arc that bends toward the viewer. See ``ArcLayout``.
    static func arc(
        radius: Float = 1,
        spacing: Float = 0.3,
        maximumAngle: Float = .pi,
        facing: SpatialFacing = .center
    ) -> ArcLayout {
        ArcLayout(radius: radius, spacing: spacing, maximumAngle: maximumAngle, facing: facing)
    }
}

public extension SpatialLayout where Self == RingLayout {
    /// Items evenly spaced on a closed horizontal circle. See ``RingLayout``.
    static func ring(radius: Float = 0.5, rotation: Float = 0, facing: SpatialFacing = .outward) -> RingLayout {
        RingLayout(radius: radius, rotation: rotation, facing: facing)
    }
}

public extension SpatialLayout where Self == GridLayout {
    /// Items in columns, rows and layers. See ``GridLayout``.
    static func grid(columns: Int = 4, rows: Int = 3, spacing: SIMD3<Float> = SIMD3<Float>(0.25, 0.25, 0.25)) -> GridLayout {
        GridLayout(columns: columns, rows: rows, spacing: spacing)
    }
}

public extension SpatialLayout where Self == SphereLayout {
    /// Items spread evenly over a sphere. See ``SphereLayout``.
    static func sphere(radius: Float = 0.5, facing: SpatialFacing = .outward) -> SphereLayout {
        SphereLayout(radius: radius, facing: facing)
    }
}

public extension SpatialLayout where Self == HelixLayout {
    /// Items on a rising spiral. See ``HelixLayout``.
    static func helix(
        radius: Float = 0.5,
        rise: Float = 0.05,
        itemsPerTurn: Float = 8,
        facing: SpatialFacing = .outward
    ) -> HelixLayout {
        HelixLayout(radius: radius, rise: rise, itemsPerTurn: itemsPerTurn, facing: facing)
    }
}

/// A layout moved by a fixed translation. Create it with ``SpatialLayout/offset(_:)``.
public struct OffsetLayout<Base: SpatialLayout>: SpatialLayout {
    /// The layout that is moved.
    public var base: Base
    /// The translation added to every position, in meters.
    public var translation: SIMD3<Float>

    public func placements(count: Int) -> [SpatialPlacement] {
        // A translation that is not finite is ignored; huge ones are limited like layout lengths.
        let limit = SIMD3<Float>(repeating: SpatialLayoutLimits.maximumLength)
        let translation = simd_clamp(SpatialMath.finite(translation, or: .zero), -limit, limit)
        return base.placements(count: count).map { placement in
            SpatialPlacement(position: placement.position + translation, orientation: placement.orientation)
        }
    }
}

extension OffsetLayout: Equatable where Base: Equatable {}

public extension SpatialLayout {
    /// The same layout, moved by `translation` meters.
    ///
    /// ```swift
    /// // A ring whose front item sits at the origin instead of its center.
    /// let carousel = RingLayout(radius: 0.3).offset([0, 0, -0.3])
    /// ```
    ///
    /// A translation with a NaN or infinite component is ignored, and components are limited to
    /// ±``SpatialLayoutLimits/maximumLength``.
    func offset(_ translation: SIMD3<Float>) -> OffsetLayout<Self> {
        OffsetLayout(base: self, translation: translation)
    }
}
