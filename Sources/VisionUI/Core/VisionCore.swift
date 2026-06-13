import SwiftUI

/// Main entry point for the VisionOS UI Framework.
public enum VisionUI {
    public static let version = "2.0.0"
}

/// A standard for spatial components in VisionOS.
public struct SpatialModifier: ViewModifier {
    public let depth: CGFloat
    
    public init(depth: CGFloat = 20) {
        self.depth = depth
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.2), radius: depth / 2, x: 0, y: depth / 4)
            // Note: actual z-offset would require .offset(z:) which is VisionOS specific
    }
}

public extension View {
    /// Applies a world-class spatial depth effect.
    func spatialDepth(_ depth: CGFloat = 20) -> some View {
        self.modifier(SpatialModifier(depth: depth))
    }
}
