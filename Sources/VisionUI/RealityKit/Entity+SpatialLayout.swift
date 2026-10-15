#if canImport(RealityKit)
import Foundation
import RealityKit

public extension Transform {
    /// A transform with the placement's position and orientation.
    ///
    /// - Parameters:
    ///   - placement: The position and orientation to use.
    ///   - scale: The scale to keep. Placements carry no scale, so pass the entity's own.
    init(_ placement: SpatialPlacement, scale: SIMD3<Float> = SIMD3<Float>(repeating: 1)) {
        self.init(scale: scale, rotation: placement.orientation, translation: placement.position)
    }
}

@MainActor
public extension Entity {
    /// Moves the entity to a placement, relative to its parent, and keeps its scale.
    ///
    /// The placement is ``SpatialPlacement/sanitized`` first, so a NaN or infinite value never
    /// reaches the entity.
    func apply(_ placement: SpatialPlacement) {
        let placement = placement.sanitized
        position = placement.position
        orientation = placement.orientation
    }

    /// Places the entity's children with a layout, in the order they were added.
    ///
    /// Children beyond ``SpatialLayoutLimits/maximumItemCount`` keep their transforms. Each child
    /// keeps its scale.
    ///
    /// ```swift
    /// RealityView { content in
    ///     let shelf = Entity()
    ///     for color in [UIColor.systemBlue, .systemTeal, .systemIndigo] {
    ///         shelf.addChild(ModelEntity(mesh: .generateBox(size: 0.1), materials: [SimpleMaterial(color: color, isMetallic: false)]))
    ///     }
    ///     shelf.arrangeChildren(using: .arc(radius: 0.5, spacing: 0.15))
    ///     content.add(shelf)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - layout: The layout that gives each child its position and orientation.
    ///   - duration: Seconds to animate each child to its place. `0`, a negative value or NaN
    ///     moves them at once. Animation needs the entity to be in a scene.
    ///   - timingFunction: The curve of the animation.
    /// - Returns: The number of children that were placed.
    @discardableResult
    func arrangeChildren(
        using layout: some SpatialLayout,
        duration: TimeInterval = 0,
        timingFunction: AnimationTimingFunction = .easeInOut
    ) -> Int {
        Self.arrange(Array(children), using: layout, relativeTo: self, duration: duration, timingFunction: timingFunction)
    }

    /// Places any entities with a layout, relative to `reference`.
    ///
    /// Use it when the entities do not share a parent. Entities beyond
    /// ``SpatialLayoutLimits/maximumItemCount`` keep their transforms.
    ///
    /// - Parameters:
    ///   - entities: The entities to place, in layout order.
    ///   - layout: The layout that gives each entity its position and orientation.
    ///   - reference: The entity whose space the placements are in; `nil` means world space.
    ///   - duration: Seconds to animate each entity to its place; `0`, negative or NaN moves them at once.
    ///   - timingFunction: The curve of the animation.
    /// - Returns: The number of entities that were placed.
    @discardableResult
    static func arrange(
        _ entities: [Entity],
        using layout: some SpatialLayout,
        relativeTo reference: Entity?,
        duration: TimeInterval = 0,
        timingFunction: AnimationTimingFunction = .easeInOut
    ) -> Int {
        let placements = layout.placements(count: entities.count)
        let animated = duration.isFinite && duration > 0
        for (entity, placement) in zip(entities, placements) {
            let target = Transform(placement.sanitized, scale: entity.scale(relativeTo: reference))
            if animated {
                entity.move(to: target, relativeTo: reference, duration: duration, timingFunction: timingFunction)
            } else {
                entity.setTransformMatrix(target.matrix, relativeTo: reference)
            }
        }
        return placements.count
    }
}
#endif
