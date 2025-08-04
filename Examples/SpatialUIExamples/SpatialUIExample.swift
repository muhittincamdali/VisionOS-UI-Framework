import SwiftUI
import RealityKit
import VisionOSUIFramework

struct SpatialUIExample: View {
    @State private var isExpanded = false
    @State private var rotation: Double = 0.0
    @State private var scale: Float = 1.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Spatial UI Examples")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Basic Spatial View
            SpatialView {
                Model3D(named: "Cube")
                    .scale(scale)
                    .rotation(.degrees(rotation))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            rotation += 360
                            scale = scale == 1.0 ? 1.5 : 1.0
                        }
                    }
            }
            .frame(width: 200, height: 200)
            
            // Floating UI Panel
            FloatingPanel {
                VStack(spacing: 15) {
                    Text("Spatial Panel")
                        .font(.headline)
                    
                    Button("Expand") {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if isExpanded {
                        Text("This is an expanded spatial panel with interactive elements.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
            }
            .frame(width: 300, height: isExpanded ? 200 : 100)
            
            // Spatial Button
            SpatialButton(
                title: "Spatial Action",
                icon: "star.fill"
            ) {
                print("Spatial button tapped")
            }
            .frame(width: 150, height: 60)
            
            // 3D Text
            SpatialText(
                text: "Hello VisionOS",
                font: .largeTitle,
                color: .blue
            )
            .frame(width: 300, height: 100)
            
            Spacer()
        }
        .padding()
    }
}

struct SpatialUIExample_Previews: PreviewProvider {
    static var previews: some View {
        SpatialUIExample()
    }
} 