import SwiftUI
import RealityKit
import VisionOSUIFramework

struct ThreeDInteractionExample: View {
    @State private var selectedObject: String?
    @State private var dragOffset = CGSize.zero
    @State private var rotationAngle: Double = 0.0
    @State private var scale: Float = 1.0
    
    var body: some View {
        VStack(spacing: 25) {
            Text("3D Interaction Examples")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 3D Object Selection
            SpatialView {
                VStack(spacing: 20) {
                    // Interactive Cube
                    Model3D(named: "Cube")
                        .scale(scale)
                        .rotation(.degrees(rotationAngle))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        dragOffset = .zero
                                    }
                                }
                        )
                        .onTapGesture {
                            selectedObject = "cube"
                        }
                    
                    // Interactive Sphere
                    Model3D(named: "Sphere")
                        .scale(scale * 0.8)
                        .rotation(.degrees(-rotationAngle))
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = Float(value)
                                }
                        )
                        .onTapGesture {
                            selectedObject = "sphere"
                        }
                }
            }
            .frame(width: 250, height: 250)
            
            // Interaction Controls
            VStack(spacing: 15) {
                Text("Interaction Controls")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    Button("Rotate") {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            rotationAngle += 90
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Scale") {
                        withAnimation(.spring()) {
                            scale = scale == 1.0 ? 1.5 : 1.0
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
                if let selected = selectedObject {
                    Text("Selected: \(selected)")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Gesture Recognition
            VStack(spacing: 10) {
                Text("Gesture Recognition")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Button("Pinch") {
                        // Handle pinch gesture
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Pan") {
                        // Handle pan gesture
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Rotate") {
                        // Handle rotation gesture
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            Spacer()
        }
        .padding()
    }
}

struct ThreeDInteractionExample_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDInteractionExample()
    }
} 