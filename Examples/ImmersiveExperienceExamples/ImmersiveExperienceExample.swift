import SwiftUI
import RealityKit
import VisionOSUIFramework

struct ImmersiveExperienceExample: View {
    @State private var isImmersive = false
    @State private var environmentType: EnvironmentType = .space
    @State private var audioEnabled = true
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Immersive Experience Examples")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Immersive Space
            ImmersiveSpace {
                Model3D(named: "SpaceStation")
                    .scale(2.0)
                    .rotation(.degrees(45))
            }
            .frame(width: 300, height: 300)
            
            // Environment Controls
            VStack(spacing: 15) {
                Text("Environment Settings")
                    .font(.headline)
                
                Picker("Environment", selection: $environmentType) {
                    Text("Space").tag(EnvironmentType.space)
                    Text("Forest").tag(EnvironmentType.forest)
                    Text("Ocean").tag(EnvironmentType.ocean)
                    Text("Desert").tag(EnvironmentType.desert)
                }
                .pickerStyle(.segmented)
                
                Toggle("Audio", isOn: $audioEnabled)
                    .toggleStyle(.switch)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Immersive Controls
            HStack(spacing: 20) {
                Button("Enter Immersive") {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        isImmersive = true
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Exit Immersive") {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        isImmersive = false
                    }
                }
                .buttonStyle(.bordered)
            }
            
            // Spatial Audio Controls
            VStack(spacing: 10) {
                Text("Spatial Audio")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Button("Play Ambient") {
                        // Play ambient spatial audio
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Stop Audio") {
                        // Stop spatial audio
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

enum EnvironmentType {
    case space, forest, ocean, desert
}

struct ImmersiveExperienceExample_Previews: PreviewProvider {
    static var previews: some View {
        ImmersiveExperienceExample()
    }
} 