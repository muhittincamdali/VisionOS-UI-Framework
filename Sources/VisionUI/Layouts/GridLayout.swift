import simd

/// Items in columns, rows and layers, centered on the origin.
///
/// Items fill a row from left to right, then the rows from top to bottom. When a layer of
/// `columns × rows` items is full, the next layer starts behind it, `spacing.z` meters further
/// from the viewer. Every item faces the viewer.
///
/// The grid is centered on the items it holds: three items in a four-column grid make a row of
/// three around the origin, not a row of four with a gap.
///
/// ```swift
/// let shelf = GridLayout(columns: 5, rows: 2, spacing: [0.22, 0.3, 0.2])
/// ```
public struct GridLayout: SpatialLayout, Equatable {
    /// The number of items in a row.
    public var columns: Int
    /// The number of rows in a layer.
    public var rows: Int
    /// The distance between item centers along `x` (columns), `y` (rows) and `z` (layers), in
    /// meters.
    public var spacing: SIMD3<Float>

    /// Creates a grid layout.
    ///
    /// Columns and rows are clamped to `1...SpatialLayoutLimits.maximumItemCount`. Each spacing
    /// component is clamped to `0...SpatialLayoutLimits.maximumLength`, and NaN becomes `0`.
    ///
    /// - Parameters:
    ///   - columns: The number of items in a row.
    ///   - rows: The number of rows in a layer.
    ///   - spacing: The distance between item centers on each axis, in meters.
    public init(columns: Int = 4, rows: Int = 3, spacing: SIMD3<Float> = SIMD3<Float>(0.25, 0.25, 0.25)) {
        self.columns = columns
        self.rows = rows
        self.spacing = spacing
    }

    /// The column, row and layer of the item at `index`, or `nil` when the index is negative or
    /// beyond ``SpatialLayoutLimits/maximumItemCount``.
    public func cell(at index: Int) -> (column: Int, row: Int, layer: Int)? {
        guard index >= 0, index < SpatialLayoutLimits.maximumItemCount else { return nil }
        let columns = clampedColumns
        let perLayer = columns * clampedRows
        return (index % columns, (index % perLayer) / columns, index / perLayer)
    }

    public func placements(count: Int) -> [SpatialPlacement] {
        let count = SpatialLayoutLimits.clampedCount(count)
        guard count > 0 else { return [] }
        let columns = clampedColumns
        let rows = clampedRows
        let perLayer = columns * rows
        let step = SIMD3<Float>(Self.nonNegative(spacing.x), Self.nonNegative(spacing.y), Self.nonNegative(spacing.z))

        // Extent of the occupied cells, so that a partly filled grid is still centered.
        let usedColumns = min(columns, count)
        let usedRows = min(rows, (count + columns - 1) / columns)
        let usedLayers = (count + perLayer - 1) / perLayer
        let offset = SIMD3<Float>(Float(usedColumns - 1), Float(usedRows - 1), Float(usedLayers - 1)) / 2

        return (0..<count).map { index in
            let column = Float(index % columns)
            let row = Float((index % perLayer) / columns)
            let layer = Float(index / perLayer)
            let position = SIMD3<Float>(
                (column - offset.x) * step.x,
                (offset.y - row) * step.y,
                (offset.z - layer) * step.z
            )
            return SpatialPlacement(position: position)
        }
    }

    // Clamping both factors to the item limit keeps `columns * rows` far from overflowing `Int`.
    private var clampedColumns: Int { min(max(columns, 1), SpatialLayoutLimits.maximumItemCount) }
    private var clampedRows: Int { min(max(rows, 1), SpatialLayoutLimits.maximumItemCount) }

    private static func nonNegative(_ value: Float) -> Float {
        SpatialLayoutLimits.clampedLength(value, fallback: 0)
    }
}
