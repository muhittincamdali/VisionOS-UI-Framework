import SwiftUI
import VisionUI

@available(visionOS 1.0, *)
struct ImmersiveExperienceExample: View {
    @State private var isImmersive: Bool = false

    var body: some View {
        ZStack {
            // Placeholder background; replace with VisionUI immersive background when integrating
            LinearGradient(colors: [.black, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("Immersive Experience")
                    .font(.title)

                HStack(spacing: 12) {
                    Button("Enter Immersive") { isImmersive = true }
                    Button("Exit") { isImmersive = false }
                }
            }
        }
    }
}

#Preview(available: visionOS 1.0) {
    ImmersiveExperienceExample()
}

