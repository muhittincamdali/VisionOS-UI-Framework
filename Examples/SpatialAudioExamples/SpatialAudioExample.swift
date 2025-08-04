import SwiftUI
import RealityKit
import VisionOSUIFramework

struct SpatialAudioExample: View {
    @State private var audioEnabled = false
    @State private var volume: Float = 0.5
    @State private var audioSource: AudioSource = .ambient
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Spatial Audio Examples")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Audio Visualization
            SpatialView {
                VStack(spacing: 20) {
                    // Audio Source Visualization
                    Circle()
                        .fill(audioEnabled ? Color.blue : Color.gray)
                        .frame(width: 100, height: 100)
                        .scaleEffect(isPlaying ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isPlaying)
                    
                    // Audio Waveform
                    HStack(spacing: 5) {
                        ForEach(0..<10, id: \.self) { index in
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 3, height: CGFloat.random(in: 10...50))
                                .animation(.easeInOut(duration: 0.3), value: isPlaying)
                        }
                    }
                }
            }
            .frame(width: 200, height: 200)
            
            // Audio Controls
            VStack(spacing: 15) {
                Text("Audio Controls")
                    .font(.headline)
                
                Toggle("Enable Audio", isOn: $audioEnabled)
                    .toggleStyle(.switch)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Volume: \(Int(volume * 100))%")
                        .font(.caption)
                    
                    Slider(value: $volume, in: 0...1)
                        .disabled(!audioEnabled)
                }
                
                Picker("Audio Source", selection: $audioSource) {
                    Text("Ambient").tag(AudioSource.ambient)
                    Text("Music").tag(AudioSource.music)
                    Text("Effects").tag(AudioSource.effects)
                    Text("Voice").tag(AudioSource.voice)
                }
                .pickerStyle(.segmented)
                .disabled(!audioEnabled)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // Playback Controls
            HStack(spacing: 20) {
                Button("Play") {
                    isPlaying = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(!audioEnabled)
                
                Button("Pause") {
                    isPlaying = false
                }
                .buttonStyle(.bordered)
                .disabled(!audioEnabled)
                
                Button("Stop") {
                    isPlaying = false
                    volume = 0.5
                }
                .buttonStyle(.bordered)
                .disabled(!audioEnabled)
            }
            
            // Spatial Audio Settings
            VStack(spacing: 10) {
                Text("Spatial Settings")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Button("3D Audio") {
                        // Enable 3D spatial audio
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Stereo") {
                        // Enable stereo audio
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Mono") {
                        // Enable mono audio
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

enum AudioSource {
    case ambient, music, effects, voice
}

struct SpatialAudioExample_Previews: PreviewProvider {
    static var previews: some View {
        SpatialAudioExample()
    }
} 