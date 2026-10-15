import simd

/// Limits for ``ManipulationState``: where an object may go, how far it may scale, how it may
/// turn.
public struct ManipulationConstraints: Sendable, Equatable {
    /// How an object may turn.
    public enum Rotation: Sendable, Equatable, CaseIterable {
        /// Any rotation.
        case free
        /// Only around the vertical axis, so the object stays upright.
        case yaw
        /// No rotation.
        case locked
    }

    /// The default scale range.
    public static let defaultScaleRange: ClosedRange<Float> = 0.25...4

    /// The box the object's position stays in, or `nil` for no limit.
    public var bounds: SpatialBounds?
    /// The smallest and largest scale. Always positive and finite.
    public private(set) var scaleRange: ClosedRange<Float>
    /// How the object may turn.
    public var rotation: Rotation
    /// The angle, in radians, that the yaw snaps to when a rotation ends, or `nil` for no snapping.
    /// Used only with ``Rotation/yaw``.
    public var yawSnapAngle: Float?

    /// Creates constraints.
    ///
    /// - Parameters:
    ///   - bounds: The box the position stays in, or `nil` for no limit.
    ///   - scaleRange: The smallest and largest scale. Bounds that are not positive and finite are
    ///     replaced: a lower bound with `0.01` and an upper bound with `100`.
    ///   - rotation: How the object may turn.
    ///   - yawSnapAngle: The angle the yaw snaps to when a rotation ends, in radians.
    public init(
        bounds: SpatialBounds? = nil,
        scaleRange: ClosedRange<Float> = defaultScaleRange,
        rotation: Rotation = .free,
        yawSnapAngle: Float? = nil
    ) {
        self.bounds = bounds
        self.scaleRange = Self.sanitized(scaleRange)
        self.rotation = rotation
        self.yawSnapAngle = yawSnapAngle
    }

    /// Replaces the scale range, with the same corrections as the initializer.
    public mutating func setScaleRange(_ range: ClosedRange<Float>) {
        scaleRange = Self.sanitized(range)
    }

    private static func sanitized(_ range: ClosedRange<Float>) -> ClosedRange<Float> {
        let lower = range.lowerBound.isFinite && range.lowerBound > 0 ? range.lowerBound : 0.01
        let upper = range.upperBound.isFinite && range.upperBound > 0 ? range.upperBound : 100
        return min(lower, upper)...max(lower, upper)
    }
}

/// The position, scale and orientation of an object that a person moves, resizes and turns with
/// gestures, kept within ``ManipulationConstraints``.
///
/// Each gesture reports its change since it began. The state remembers the value at the start of
/// each gesture separately, so a drag and a pinch at the same time each apply to their own
/// starting point, and a gesture that ends does not disturb the others.
///
/// ```swift
/// var state = ManipulationState(constraints: .init(
///     bounds: SpatialBounds(center: .zero, size: [1, 0.6, 1]),
///     rotation: .yaw,
///     yawSnapAngle: .pi / 4
/// ))
/// state.drag(translation: [0.2, 0, 0])   // during the gesture
/// state.endDrag()                        // when it ends
/// ```
///
/// Values that are NaN or infinite, a non-positive magnification and a zero rotation are
/// ignored, so a glitch in a gesture never moves an object out of reach.
public struct ManipulationState: Sendable, Equatable {
    /// The object's position, in meters, inside the constraints' bounds.
    public private(set) var position: SIMD3<Float>
    /// The object's uniform scale, inside the constraints' scale range.
    public private(set) var scale: Float
    /// The object's orientation.
    public private(set) var orientation: simd_quatf
    /// The limits the state keeps to. Changing them moves the object inside the new limits.
    public var constraints: ManipulationConstraints {
        didSet { position = constrained(position); scale = constrained(scale); orientation = constrained(orientation) }
    }

    private var dragStart: SIMD3<Float>?
    private var magnifyStart: Float?
    private var rotationStart: simd_quatf?

    /// Creates a state, moved inside the constraints.
    public init(
        position: SIMD3<Float> = .zero,
        scale: Float = 1,
        orientation: simd_quatf = SpatialMath.identity,
        constraints: ManipulationConstraints = ManipulationConstraints()
    ) {
        self.constraints = constraints
        self.position = .zero
        self.scale = 1
        self.orientation = SpatialMath.identity
        self.position = constrained(SpatialMath.finite(position, or: .zero))
        self.scale = constrained(scale.isFinite ? scale : 1)
        self.orientation = constrained(orientation)
    }

    /// Whether a drag, pinch or rotation is in progress.
    public var isInteracting: Bool {
        dragStart != nil || magnifyStart != nil || rotationStart != nil
    }

    /// The transform of the object: scale, then rotation, then translation.
    public var matrix: simd_float4x4 {
        let rotation = simd_float4x4(orientation)
        var matrix = rotation * simd_float4x4(diagonal: SIMD4<Float>(scale, scale, scale, 1))
        matrix.columns.3 = SIMD4<Float>(position, 1)
        return matrix
    }

    // MARK: Drag

    /// Moves the object by `translation`, in meters, from where it was when the drag began.
    public mutating func drag(translation: SIMD3<Float>) {
        guard translation.x.isFinite, translation.y.isFinite, translation.z.isFinite else { return }
        let start = dragStart ?? position
        dragStart = start
        position = constrained(start + translation)
    }

    /// Ends the drag.
    public mutating func endDrag() {
        dragStart = nil
    }

    // MARK: Magnify

    /// Scales the object by `magnification` relative to its scale when the pinch began.
    ///
    /// `1` keeps the starting scale, `2` doubles it. Values that are not positive and finite are
    /// ignored.
    public mutating func magnify(by magnification: Float) {
        guard magnification.isFinite, magnification > 0 else { return }
        let start = magnifyStart ?? scale
        magnifyStart = start
        let scaled = start * magnification
        guard scaled.isFinite else { return }
        scale = constrained(scaled)
    }

    /// Ends the pinch.
    public mutating func endMagnify() {
        magnifyStart = nil
    }

    // MARK: Rotate

    /// Turns the object by `rotation` from its orientation when the rotation began.
    ///
    /// With ``ManipulationConstraints/Rotation/yaw`` only the part of `rotation` around the
    /// vertical axis is used; with ``ManipulationConstraints/Rotation/locked`` nothing happens.
    public mutating func rotate(by rotation: simd_quatf) {
        let vector = rotation.vector
        guard vector.x.isFinite, vector.y.isFinite, vector.z.isFinite, vector.w.isFinite,
              simd_length(vector) > 1e-6 else { return }
        let start = rotationStart ?? orientation
        rotationStart = start
        orientation = constrained(simd_normalize(rotation) * start)
    }

    /// Ends the rotation and snaps the yaw when the constraints ask for it.
    public mutating func endRotation() {
        rotationStart = nil
        guard constraints.rotation == .yaw, let step = constraints.yawSnapAngle else { return }
        orientation = SpatialMath.yawRotation(SpatialMath.snapped(Self.yawAngle(of: orientation), to: step))
    }

    /// Ends every gesture in progress.
    public mutating func endInteraction() {
        endDrag()
        endMagnify()
        endRotation()
    }

    /// Moves the object to `position`, kept inside the bounds. NaN or infinite values are ignored.
    public mutating func move(to position: SIMD3<Float>) {
        guard position.x.isFinite, position.y.isFinite, position.z.isFinite else { return }
        self.position = constrained(position)
    }

    // MARK: Constraints

    private func constrained(_ position: SIMD3<Float>) -> SIMD3<Float> {
        guard let bounds = constraints.bounds else { return position }
        return bounds.clamp(position)
    }

    private func constrained(_ scale: Float) -> Float {
        min(max(scale, constraints.scaleRange.lowerBound), constraints.scaleRange.upperBound)
    }

    private func constrained(_ orientation: simd_quatf) -> simd_quatf {
        let vector = orientation.vector
        guard vector.x.isFinite, vector.y.isFinite, vector.z.isFinite, vector.w.isFinite,
              simd_length(vector) > 1e-6 else { return SpatialMath.identity }
        switch constraints.rotation {
        case .free: return simd_normalize(orientation)
        case .locked: return SpatialMath.identity
        case .yaw: return SpatialMath.yawRotation(Self.yawAngle(of: orientation))
        }
    }

    /// The angle of the twist of `rotation` around `+y`: the rotation with the tilt removed.
    static func yawAngle(of rotation: simd_quatf) -> Float {
        let vector = rotation.vector
        let length = (vector.y * vector.y + vector.w * vector.w).squareRoot()
        // A half turn around a horizontal axis has no defined twist; keep the object unturned.
        guard length > 1e-6 else { return 0 }
        return SpatialMath.wrappedAngle(2 * atan2(vector.y, vector.w))
    }
}
