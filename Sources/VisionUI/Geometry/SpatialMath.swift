import simd

/// Small geometry helpers shared by the layouts, the carousel and the manipulation state.
///
/// Every function accepts any `Float`, including NaN and infinity, and returns a finite result.
public enum SpatialMath {
    /// A rotation that leaves everything as it is.
    public static let identity = simd_quatf(ix: 0, iy: 0, iz: 0, r: 1)

    /// The value itself when it is finite, otherwise `fallback`.
    @inlinable
    public static func finite(_ value: Float, or fallback: Float) -> Float {
        value.isFinite ? value : fallback
    }

    /// The vector itself when all three components are finite, otherwise `fallback`.
    @inlinable
    public static func finite(_ vector: SIMD3<Float>, or fallback: SIMD3<Float>) -> SIMD3<Float> {
        vector.x.isFinite && vector.y.isFinite && vector.z.isFinite ? vector : fallback
    }

    /// The rotation around `+y` by `angle` radians. Positive angles turn `+z` toward `+x`.
    public static func yawRotation(_ angle: Float) -> simd_quatf {
        simd_quatf(angle: finite(angle, or: 0), axis: SIMD3<Float>(0, 1, 0))
    }

    /// The yaw, in radians, of a direction projected on the floor: `0` for `+z`, `π/2` for `+x`.
    ///
    /// Returns `0` for a vertical, zero-length or non-finite direction.
    public static func yaw(of direction: SIMD3<Float>) -> Float {
        guard direction.x.isFinite, direction.z.isFinite else { return 0 }
        guard direction.x * direction.x + direction.z * direction.z > 1e-12 else { return 0 }
        return atan2(direction.x, direction.z)
    }

    /// A rotation that turns the front (`+z`) toward `direction` and keeps the item's top as close
    /// to `up` as possible.
    ///
    /// When `direction` is parallel to `up`, the top points to `-z` instead; when `direction` is
    /// zero or not finite, the identity is returned.
    public static func facing(_ direction: SIMD3<Float>, up: SIMD3<Float> = SIMD3<Float>(0, 1, 0)) -> simd_quatf {
        let length = simd_length(finite(direction, or: .zero))
        guard length > 1e-6, length.isFinite else { return identity }
        let front = direction / length
        var upHint = simd_normalize(finite(up, or: SIMD3<Float>(0, 1, 0)))
        if !upHint.x.isFinite || abs(simd_dot(upHint, front)) > 0.9999 {
            upHint = abs(front.z) < 0.9999 ? SIMD3<Float>(0, 0, -1) : SIMD3<Float>(0, 1, 0)
            if abs(simd_dot(upHint, front)) > 0.9999 { upHint = SIMD3<Float>(1, 0, 0) }
        }
        let right = simd_normalize(simd_cross(upHint, front))
        let top = simd_cross(front, right)
        return simd_normalize(simd_quatf(simd_float3x3(columns: (right, top, front))))
    }

    /// The angle wrapped into `(-π, π]`. Non-finite angles become `0`.
    public static func wrappedAngle(_ angle: Float) -> Float {
        guard angle.isFinite else { return 0 }
        var wrapped = fmodf(angle, 2 * .pi)
        if wrapped <= -.pi { wrapped += 2 * .pi }
        if wrapped > .pi { wrapped -= 2 * .pi }
        return wrapped
    }

    /// The angle rounded to the nearest multiple of `step`, or unchanged when `step` is not a
    /// positive finite number.
    public static func snapped(_ angle: Float, to step: Float) -> Float {
        guard angle.isFinite else { return 0 }
        guard step.isFinite, step > 1e-6 else { return angle }
        let result = (angle / step).rounded() * step
        return result.isFinite ? result : angle
    }
}
