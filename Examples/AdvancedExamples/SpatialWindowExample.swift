import SwiftUI
import VisionUI

@available(visionOS 1.0, *)
struct SpatialWindowExample: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Spatial Window")
                .font(.largeTitle)

            Text("Open a floating spatial window positioned in 3D space.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Button("Open Window") {
                // Example: trigger a floating spatial window using VisionUI
                // Replace with integration point in the demo host app
            }
        }
        .padding(24)
    }
}

#Preview(available: visionOS 1.0) {
    SpatialWindowExample()
}

