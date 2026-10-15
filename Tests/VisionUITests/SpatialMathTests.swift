import Foundation
import simd
import Testing
@testable import VisionUI

@Suite("Spatial math")
struct SpatialMathTests {
    @Test("facing turns the front toward the direction", arguments: [
        SIMD3<Float>(1, 0, 0), SIMD3<Float>(-1, 0, 0), SIMD3<Float>(0, 0, -1), SIMD3<Float>(0, 0, 1),
        SIMD3<Float>(0, 1, 0), SIMD3<Float>(0, -1, 0), SIMD3<Float>(0.3, -0.8, 0.2), SIMD3<Float>(-2, 5, 7),
    ])
    func facingDirection(direction: SIMD3<Float>) {
        let rotation = SpatialMath.facing(direction)
        #expect(isClose(rotation.act(SIMD3<Float>(0, 0, 1)), simd_normalize(direction)))
        // A rotation never stretches: the length of every axis stays 1.
        #expect(isClose(simd_length(rotation.act(SIMD3<Float>(1, 0, 0))), 1))
    }

    @Test("facing keeps the top up for horizontal directions")
    func facingKeepsTopUp() {
        for degrees in stride(from: 0, to: 360, by: 15) {
            let angle = Float(degrees) * .pi / 180
            let rotation = SpatialMath.facing(SIMD3<Float>(sin(angle), 0, cos(angle)))
            #expect(isClose(rotation.act(SIMD3<Float>(0, 1, 0)), SIMD3<Float>(0, 1, 0)))
        }
    }

    @Test("facing a zero or non-finite direction is no rotation")
    func facingDegenerate() {
        for direction in [SIMD3<Float>.zero, SIMD3<Float>(.nan, 0, 1), SIMD3<Float>(.infinity, 0, 0)] {
            #expect(SpatialMath.facing(direction) == SpatialMath.identity)
        }
        // A broken `up` hint still gives a valid rotation.
        let rotation = SpatialMath.facing(SIMD3<Float>(1, 0, 0), up: SIMD3<Float>(.nan, .nan, .nan))
        #expect(isClose(rotation.act(SIMD3<Float>(0, 0, 1)), SIMD3<Float>(1, 0, 0)))
    }

    @Test("yaw and yawRotation are inverses")
    func yawRoundTrip() {
        for angle in stride(from: Float(-3.1), through: 3.1, by: 0.2) {
            let forward = SpatialMath.yawRotation(angle).act(SIMD3<Float>(0, 0, 1))
            #expect(isClose(SpatialMath.yaw(of: forward), angle, within: Tolerance.angle))
        }
        #expect(isClose(SpatialMath.yaw(of: SIMD3<Float>(1, 0, 0)), .pi / 2))
        #expect(SpatialMath.yaw(of: SIMD3<Float>(0, 1, 0)) == 0)
        #expect(SpatialMath.yaw(of: SIMD3<Float>(.nan, 0, 1)) == 0)
        #expect(SpatialMath.yawRotation(.nan) == SpatialMath.identity)
    }

    @Test("wrappedAngle stays in (-π, π]")
    func wrapping() {
        #expect(isClose(SpatialMath.wrappedAngle(2 * .pi + 0.5), 0.5))
        #expect(isClose(SpatialMath.wrappedAngle(-0.5), -0.5))
        #expect(isClose(SpatialMath.wrappedAngle(7 * .pi - 0.25), .pi - 0.25, within: 1e-3))
        #expect(isClose(SpatialMath.wrappedAngle(-9 * .pi + 0.25), -.pi + 0.25, within: 1e-3))
        // Whatever the input, the result is the same direction.
        for angle in stride(from: Float(-40), through: 40, by: 0.7) {
            let wrapped = SpatialMath.wrappedAngle(angle)
            #expect(isClose(cos(wrapped), cos(angle), within: 1e-3) && isClose(sin(wrapped), sin(angle), within: 1e-3))
        }
        for value in hostileFloats {
            let wrapped = SpatialMath.wrappedAngle(value)
            #expect(wrapped.isFinite && wrapped > -.pi - 1e-4 && wrapped <= .pi + 1e-4)
        }
    }

    @Test("snapped rounds to the step and survives extreme values")
    func snapping() {
        #expect(isClose(SpatialMath.snapped(0.4, to: 0.25), 0.5))
        #expect(isClose(SpatialMath.snapped(-0.4, to: 0.25), -0.5))
        #expect(SpatialMath.snapped(0.4, to: 0) == 0.4)
        #expect(SpatialMath.snapped(0.4, to: .nan) == 0.4)
        #expect(SpatialMath.snapped(.nan, to: 0.25) == 0)
        // `max / 0.01` overflows to infinity; the angle comes back unchanged instead.
        #expect(SpatialMath.snapped(.greatestFiniteMagnitude, to: 0.01) == .greatestFiniteMagnitude)
    }

    @Test("placement forward and yaw follow the orientation")
    func placementAxes() {
        let placement = SpatialPlacement(position: .zero, orientation: SpatialMath.yawRotation(.pi / 2))
        #expect(isClose(placement.forward, SIMD3<Float>(1, 0, 0)))
        #expect(isClose(placement.yaw, .pi / 2))
    }
}
