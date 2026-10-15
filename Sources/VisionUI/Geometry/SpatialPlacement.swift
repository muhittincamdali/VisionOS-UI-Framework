import simd

/// Where one item of a spatial layout goes: a position and an orientation.
///
/// Positions are in meters and use RealityKit's axes: `+x` points right, `+y` points up and
/// `+z` points toward the viewer. An orientation of `simd_quatf(ix: 0, iy: 0, iz: 0, r: 1)`
/// (no rotation) leaves the item's front, its `+z` side, facing the viewer.
public struct SpatialPlacement: Sendable, Equatable {
    /// The item's center, in meters.
    public var position: SIMD3<Float>

    /// The item's rotation, applied around its center.
    public var orientation: simd_quatf

    /// Creates a placement.
    ///
    /// - Parameters:
    ///   - position: The item's center, in meters.
    ///   - orientation: The item's rotation. The default leaves its front facing `+z`.
    public init(position: SIMD3<Float>, orientation: simd_quatf = SpatialMath.identity) {
        self.position = position
        self.orientation = orientation
    }

    /// The direction the item's front faces: its `+z` axis after rotation.
    public var forward: SIMD3<Float> {
        orientation.act(SIMD3<Float>(0, 0, 1))
    }

    /// The rotation around the vertical axis, in radians, that turns `+z` toward the item's
    /// forward direction projected on the floor.
    ///
    /// Positive values turn the front toward `+x`. The value is `0` when the item faces straight
    /// up or down.
    public var yaw: Float {
        SpatialMath.yaw(of: forward)
    }
}
