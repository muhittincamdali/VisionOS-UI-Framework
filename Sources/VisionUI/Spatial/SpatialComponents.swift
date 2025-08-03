//
//  SpatialComponents.swift
//  VisionOS-UI-Framework
//
//  Created by Muhittin Camdali
//  Copyright © 2024 Muhittin Camdali. All rights reserved.
//

import SwiftUI
import RealityKit
import Spatial

/// Spatial Components for VisionOS
@available(visionOS 1.0, *)
public struct SpatialComponents {
    
    /// A container that provides spatial context for 3D UI elements
    public struct SpatialContainer<Content: View>: View {
        private let content: Content
        private let lighting: SpatialLighting
        private let physics: PhysicsConfiguration
        private let audio: SpatialAudioConfiguration
        
        public init(
            lighting: SpatialLighting = .defaultLighting,
            physics: PhysicsConfiguration = .defaultPhysics,
            audio: SpatialAudioConfiguration = .defaultAudio,
            @ViewBuilder content: () -> Content
        ) {
            self.lighting = lighting
            self.physics = physics
            self.audio = audio
            self.content = content()
        }
        
        public var body: some View {
            RealityView { content in
                configureEnvironment(in: content)
                let contentEntity = Entity()
                contentEntity.addChild(content)
                content.addChild(contentEntity)
            } update: { content in
                updateEnvironment(in: content)
            }
        }
        
        private func configureEnvironment(in content: RealityViewContent) {
            let lightEntity = Entity()
            lightEntity.light = LightComponent(
                type: .directional,
                color: lighting.primaryLight.color,
                intensity: lighting.primaryLight.intensity
            )
            content.addChild(lightEntity)
            
            content.physicsWorld?.gravity = physics.gravity
            content.physicsWorld?.airResistance = physics.airResistance
            content.physicsWorld?.friction = physics.friction
            
            content.audioEngine?.reverbPreset = audio.reverbPreset
            content.audioEngine?.occlusion = audio.occlusion
            content.audioEngine?.reverbSendLevel = audio.reverbSendLevel
        }
        
        private func updateEnvironment(in content: RealityViewContent) {
            // Update spatial environment based on user interaction
        }
    }
    
    /// A 3D button designed for spatial interaction
    public struct SpatialButton: View {
        private let title: String
        private let action: () -> Void
        private let style: SpatialButtonStyle
        
        public init(
            _ title: String,
            style: SpatialButtonStyle = .primary,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.style = style
            self.action = action
        }
        
        public var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(style.textColor)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(style.backgroundColor)
                            .shadow(color: style.shadowColor, radius: 8, x: 0, y: 4)
                    )
            }
            .buttonStyle(SpatialButtonStyleModifier(style: style))
        }
    }
    
    /// A 3D card component for displaying content in spatial environments
    public struct SpatialCard<Content: View>: View {
        private let content: Content
        private let style: SpatialCardStyle
        
        public init(
            style: SpatialCardStyle = .default,
            @ViewBuilder content: () -> Content
        ) {
            self.style = style
            self.content = content()
        }
        
        public var body: some View {
            VStack(spacing: 16) {
                content
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(style.backgroundColor)
                    .shadow(color: style.shadowColor, radius: 12, x: 0, y: 6)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(style.borderColor, lineWidth: 1)
            )
        }
    }
    
    /// A spatial navigation component for 3D environments
    public struct SpatialNavigation<Content: View>: View {
        private let title: String
        private let content: Content
        private let leadingButton: (() -> AnyView)?
        private let trailingButton: (() -> AnyView)?
        
        public init(
            title: String,
            leadingButton: (() -> AnyView)? = nil,
            trailingButton: (() -> AnyView)? = nil,
            @ViewBuilder content: () -> Content
        ) {
            self.title = title
            self.leadingButton = leadingButton
            self.trailingButton = trailingButton
            self.content = content()
        }
        
        public var body: some View {
            VStack(spacing: 0) {
                HStack {
                    if let leadingButton = leadingButton {
                        leadingButton()
                    }
                    
                    Spacer()
                    
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    if let trailingButton = trailingButton {
                        trailingButton()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    /// A 3D list component for spatial environments
    public struct SpatialList<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
        private let data: Data
        private let content: (Data.Element) -> Content
        private let style: SpatialListStyle
        
        public init(
            _ data: Data,
            style: SpatialListStyle = .default,
            @ViewBuilder content: @escaping (Data.Element) -> Content
        ) {
            self.data = data
            self.style = style
            self.content = content
        }
        
        public var body: some View {
            ScrollView {
                LazyVStack(spacing: style.itemSpacing) {
                    ForEach(data) { item in
                        content(item)
                            .padding(.horizontal, style.horizontalPadding)
                    }
                }
                .padding(.vertical, style.verticalPadding)
            }
            .background(style.backgroundColor)
        }
    }
    
    /// A 3D modal component for spatial interfaces
    public struct SpatialModal<Content: View>: View {
        private let isPresented: Binding<Bool>
        private let content: Content
        private let style: SpatialModalStyle
        
        public init(
            isPresented: Binding<Bool>,
            style: SpatialModalStyle = .default,
            @ViewBuilder content: () -> Content
        ) {
            self.isPresented = isPresented
            self.style = style
            self.content = content()
        }
        
        public var body: some View {
            if isPresented.wrappedValue {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isPresented.wrappedValue = false
                            }
                        }
                    
                    VStack(spacing: 20) {
                        content
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(style.backgroundColor)
                            .shadow(color: style.shadowColor, radius: 20, x: 0, y: 10)
                    )
                    .scaleEffect(isPresented.wrappedValue ? 1.0 : 0.8)
                    .opacity(isPresented.wrappedValue ? 1.0 : 0.0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: isPresented.wrappedValue)
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
    }
}

// MARK: - Supporting Types

@available(visionOS 1.0, *)
public struct SpatialButtonStyle {
    public let backgroundColor: Color
    public let textColor: Color
    public let shadowColor: Color
    public let pressedColor: Color
    
    public static let primary = SpatialButtonStyle(
        backgroundColor: .blue,
        textColor: .white,
        shadowColor: .blue.opacity(0.3),
        pressedColor: .blue.opacity(0.8)
    )
    
    public static let secondary = SpatialButtonStyle(
        backgroundColor: .gray.opacity(0.2),
        textColor: .primary,
        shadowColor: .gray.opacity(0.2),
        pressedColor: .gray.opacity(0.3)
    )
    
    public static let success = SpatialButtonStyle(
        backgroundColor: .green,
        textColor: .white,
        shadowColor: .green.opacity(0.3),
        pressedColor: .green.opacity(0.8)
    )
    
    public static let danger = SpatialButtonStyle(
        backgroundColor: .red,
        textColor: .white,
        shadowColor: .red.opacity(0.3),
        pressedColor: .red.opacity(0.8)
    )
}

@available(visionOS 1.0, *)
public struct SpatialCardStyle {
    public let backgroundColor: Color
    public let shadowColor: Color
    public let borderColor: Color
    
    public static let `default` = SpatialCardStyle(
        backgroundColor: .ultraThinMaterial,
        shadowColor: .black.opacity(0.1),
        borderColor: .clear
    )
    
    public static let elevated = SpatialCardStyle(
        backgroundColor: .regularMaterial,
        shadowColor: .black.opacity(0.15),
        borderColor: .gray.opacity(0.2)
    )
}

@available(visionOS 1.0, *)
public struct SpatialListStyle {
    public let backgroundColor: Color
    public let itemSpacing: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    
    public static let `default` = SpatialListStyle(
        backgroundColor: .clear,
        itemSpacing: 12,
        horizontalPadding: 16,
        verticalPadding: 16
    )
    
    public static let compact = SpatialListStyle(
        backgroundColor: .clear,
        itemSpacing: 8,
        horizontalPadding: 12,
        verticalPadding: 12
    )
}

@available(visionOS 1.0, *)
public struct SpatialModalStyle {
    public let backgroundColor: Color
    public let shadowColor: Color
    
    public static let `default` = SpatialModalStyle(
        backgroundColor: .regularMaterial,
        shadowColor: .black.opacity(0.2)
    )
    
    public static let elevated = SpatialModalStyle(
        backgroundColor: .thickMaterial,
        shadowColor: .black.opacity(0.3)
    )
}

@available(visionOS 1.0, *)
private struct SpatialButtonStyleModifier: ButtonStyle {
    let style: SpatialButtonStyle
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(configuration.isPressed ? style.pressedColor : style.backgroundColor)
            )
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
} 