//
//  SpatialAccessibility.swift
//  VisionOS-UI-Framework
//
//  Created by Muhittin Camdali
//  Copyright © 2024 Muhittin Camdali. All rights reserved.
//

import SwiftUI
import RealityKit
import Spatial

/// Spatial Accessibility Framework for VisionOS
/// 
/// Comprehensive accessibility support for spatial computing interfaces,
/// including VoiceOver, Switch Control, and other accessibility features.
@available(visionOS 1.0, *)
public struct SpatialAccessibility {
    
    /// Accessibility configuration for spatial interfaces
    public struct AccessibilityConfig {
        public let voiceOverEnabled: Bool
        public let switchControlEnabled: Bool
        public let reduceMotionEnabled: Bool
        public let highContrastEnabled: Bool
        public let largeTextEnabled: Bool
        
        public init(
            voiceOverEnabled: Bool = true,
            switchControlEnabled: Bool = true,
            reduceMotionEnabled: Bool = false,
            highContrastEnabled: Bool = false,
            largeTextEnabled: Bool = false
        ) {
            self.voiceOverEnabled = voiceOverEnabled
            self.switchControlEnabled = switchControlEnabled
            self.reduceMotionEnabled = reduceMotionEnabled
            self.highContrastEnabled = highContrastEnabled
            self.largeTextEnabled = largeTextEnabled
        }
    }
    
    /// Spatial accessibility label for VoiceOver
    public struct SpatialAccessibilityLabel {
        public let label: String
        public let hint: String?
        public let traits: AccessibilityTraits
        public let value: String?
        
        public init(
            label: String,
            hint: String? = nil,
            traits: AccessibilityTraits = [],
            value: String? = nil
        ) {
            self.label = label
            self.hint = hint
            self.traits = traits
            self.value = value
        }
    }
    
    /// Spatial accessibility action
    public struct SpatialAccessibilityAction {
        public let name: String
        public let action: () -> Void
        
        public init(name: String, action: @escaping () -> Void) {
            self.name = name
            self.action = action
        }
    }
    
    /// Spatial accessibility modifier
    public struct SpatialAccessibilityModifier: ViewModifier {
        private let label: SpatialAccessibilityLabel
        private let actions: [SpatialAccessibilityAction]
        private let config: AccessibilityConfig
        
        public init(
            label: SpatialAccessibilityLabel,
            actions: [SpatialAccessibilityAction] = [],
            config: AccessibilityConfig = AccessibilityConfig()
        ) {
            self.label = label
            self.actions = actions
            self.config = config
        }
        
        public func body(content: Content) -> some View {
            content
                .accessibilityLabel(label.label)
                .accessibilityHint(label.hint ?? "")
                .accessibilityAddTraits(label.traits)
                .accessibilityValue(label.value ?? "")
                .accessibilityAction(named: Text("Activate")) {
                    // Default activation action
                }
                .accessibilityAction(named: Text("Double Tap")) {
                    // Double tap action
                }
                .accessibilityAction(named: Text("Long Press")) {
                    // Long press action
                }
        }
    }
    
    /// Spatial accessibility container
    public struct SpatialAccessibilityContainer<Content: View>: View {
        private let content: Content
        private let config: AccessibilityConfig
        
        public init(
            config: AccessibilityConfig = AccessibilityConfig(),
            @ViewBuilder content: () -> Content
        ) {
            self.config = config
            self.content = content()
        }
        
        public var body: some View {
            content
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Spatial Interface")
                .accessibilityHint("Spatial computing interface with accessibility support")
        }
    }
    
    /// Spatial accessibility navigation
    public struct SpatialAccessibilityNavigation<Content: View>: View {
        private let content: Content
        private let title: String
        private let config: AccessibilityConfig
        
        public init(
            title: String,
            config: AccessibilityConfig = AccessibilityConfig(),
            @ViewBuilder content: () -> Content
        ) {
            self.title = title
            self.config = config
            self.content = content()
        }
        
        public var body: some View {
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                content
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Navigation: \(title)")
        }
    }
    
    /// Spatial accessibility button
    public struct SpatialAccessibilityButton: View {
        private let title: String
        private let action: () -> Void
        private let config: AccessibilityConfig
        
        public init(
            _ title: String,
            config: AccessibilityConfig = AccessibilityConfig(),
            action: @escaping () -> Void
        ) {
            self.title = title
            self.config = config
            self.action = action
        }
        
        public var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .accessibilityLabel(title)
            .accessibilityHint("Double tap to activate")
            .accessibilityAddTraits(.isButton)
        }
    }
    
    /// Spatial accessibility list
    public struct SpatialAccessibilityList<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
        private let data: Data
        private let content: (Data.Element) -> Content
        private let config: AccessibilityConfig
        
        public init(
            _ data: Data,
            config: AccessibilityConfig = AccessibilityConfig(),
            @ViewBuilder content: @escaping (Data.Element) -> Content
        ) {
            self.data = data
            self.config = config
            self.content = content
        }
        
        public var body: some View {
            List(data) { item in
                content(item)
            }
            .accessibilityLabel("List with \(data.count) items")
            .accessibilityHint("Swipe to navigate through items")
        }
    }
    
    /// Spatial accessibility modal
    public struct SpatialAccessibilityModal<Content: View>: View {
        private let isPresented: Binding<Bool>
        private let content: Content
        private let config: AccessibilityConfig
        
        public init(
            isPresented: Binding<Bool>,
            config: AccessibilityConfig = AccessibilityConfig(),
            @ViewBuilder content: () -> Content
        ) {
            self.isPresented = isPresented
            self.config = config
            self.content = content()
        }
        
        public var body: some View {
            if isPresented.wrappedValue {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .accessibilityLabel("Modal background")
                        .accessibilityHint("Double tap to dismiss")
                        .onTapGesture {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    
                    VStack {
                        content
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel("Modal content")
                }
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Modal dialog")
            }
        }
    }
}

// MARK: - Accessibility Extensions

@available(visionOS 1.0, *)
public extension View {
    
    /// Add spatial accessibility support to the view
    func spatialAccessibility(
        label: SpatialAccessibility.SpatialAccessibilityLabel,
        actions: [SpatialAccessibility.SpatialAccessibilityAction] = [],
        config: SpatialAccessibility.AccessibilityConfig = SpatialAccessibility.AccessibilityConfig()
    ) -> some View {
        modifier(SpatialAccessibility.SpatialAccessibilityModifier(
            label: label,
            actions: actions,
            config: config
        ))
    }
    
    /// Make the view a spatial accessibility container
    func spatialAccessibilityContainer(
        config: SpatialAccessibility.AccessibilityConfig = SpatialAccessibility.AccessibilityConfig()
    ) -> some View {
        modifier(SpatialAccessibility.SpatialAccessibilityModifier(
            label: SpatialAccessibility.SpatialAccessibilityLabel(
                label: "Spatial Container",
                hint: "Spatial computing interface container"
            ),
            config: config
        ))
    }
}

// MARK: - Accessibility Utilities

@available(visionOS 1.0, *)
public struct SpatialAccessibilityUtilities {
    
    /// Check if VoiceOver is running
    public static var isVoiceOverRunning: Bool {
        return UIAccessibility.isVoiceOverRunning
    }
    
    /// Check if Switch Control is running
    public static var isSwitchControlRunning: Bool {
        return UIAccessibility.isSwitchControlRunning
    }
    
    /// Check if Reduce Motion is enabled
    public static var isReduceMotionEnabled: Bool {
        return UIAccessibility.isReduceMotionEnabled
    }
    
    /// Check if High Contrast is enabled
    public static var isHighContrastEnabled: Bool {
        return UIAccessibility.isHighContrastEnabled
    }
    
    /// Check if Large Text is enabled
    public static var isLargeTextEnabled: Bool {
        return UIAccessibility.isLargeTextEnabled
    }
    
    /// Announce accessibility message
    public static func announce(_ message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }
    
    /// Focus accessibility element
    public static func focus(_ element: Any) {
        UIAccessibility.post(notification: .screenChanged, argument: element)
    }
    
    /// Get current accessibility configuration
    public static func getCurrentAccessibilityConfig() -> SpatialAccessibility.AccessibilityConfig {
        return SpatialAccessibility.AccessibilityConfig(
            voiceOverEnabled: isVoiceOverRunning,
            switchControlEnabled: isSwitchControlRunning,
            reduceMotionEnabled: isReduceMotionEnabled,
            highContrastEnabled: isHighContrastEnabled,
            largeTextEnabled: isLargeTextEnabled
        )
    }
}

// MARK: - Accessibility Constants

@available(visionOS 1.0, *)
public struct SpatialAccessibilityConstants {
    
    /// Default accessibility labels
    public struct Labels {
        public static let button = "Button"
        public static let card = "Card"
        public static let list = "List"
        public static let modal = "Modal"
        public static let navigation = "Navigation"
        public static let container = "Container"
    }
    
    /// Default accessibility hints
    public struct Hints {
        public static let button = "Double tap to activate"
        public static let card = "Card content"
        public static let list = "Swipe to navigate"
        public static let modal = "Modal dialog"
        public static let navigation = "Navigation interface"
        public static let container = "Spatial container"
    }
    
    /// Default accessibility traits
    public struct Traits {
        public static let button: AccessibilityTraits = .isButton
        public static let header: AccessibilityTraits = .isHeader
        public static let image: AccessibilityTraits = .isImage
        public static let link: AccessibilityTraits = .isLink
        public static let searchField: AccessibilityTraits = .isSearchField
        public static let staticText: AccessibilityTraits = .isStaticText
    }
} 