import simd
@testable import VisionUI

/// Tolerances for comparing floating-point geometry.
enum Tolerance {
    static let position: Float = 1e-4
    static let angle: Float = 1e-4
}

func isClose(_ lhs: Float, _ rhs: Float, within tolerance: Float = Tolerance.position) -> Bool {
    abs(lhs - rhs) <= tolerance
}

func isClose(_ lhs: SIMD3<Float>, _ rhs: SIMD3<Float>, within tolerance: Float = Tolerance.position) -> Bool {
    simd_length(lhs - rhs) <= tolerance
}

/// Whether two rotations turn every vector the same way (`q` and `-q` are the same rotation).
func isSameRotation(_ lhs: simd_quatf, _ rhs: simd_quatf, within tolerance: Float = Tolerance.angle) -> Bool {
    abs(abs(simd_dot(lhs.vector, rhs.vector)) - 1) <= tolerance
}

func isFinite(_ placement: SpatialPlacement) -> Bool {
    let values = [placement.position.x, placement.position.y, placement.position.z] + [
        placement.orientation.vector.x, placement.orientation.vector.y,
        placement.orientation.vector.z, placement.orientation.vector.w,
    ]
    return values.allSatisfy(\.isFinite)
}

/// Values that a caller can pass by mistake or that arrive from a file or a server.
let hostileFloats: [Float] = [.nan, .infinity, -.infinity, .greatestFiniteMagnitude, -.greatestFiniteMagnitude, -1, 0]
