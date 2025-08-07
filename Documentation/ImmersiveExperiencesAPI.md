# Immersive Experiences API

## Overview

The Immersive Experiences API provides comprehensive tools for creating immersive spatial computing experiences in VisionOS applications. This API enables developers to build full immersive environments, mixed reality experiences, and spatial audio systems.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Core Components](#core-components)
- [Immersive Spaces](#immersive-spaces)
- [Mixed Reality](#mixed-reality)
- [Spatial Audio](#spatial-audio)
- [Environmental Effects](#environmental-effects)
- [Spatial Physics](#spatial-physics)
- [Spatial Particles](#spatial-particles)
- [Spatial Weather](#spatial-weather)
- [Spatial Time](#spatial-time)
- [Spatial Events](#spatial-events)
- [Configuration](#configuration)
- [Error Handling](#error-handling)
- [Examples](#examples)

## Installation

### Swift Package Manager

Add the VisionOS UI Framework to your project:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/VisionOS-UI-Framework.git", from: "1.0.0")
]
```

### Requirements

- **VisionOS**: 1.0+
- **Swift**: 5.9+
- **Xcode**: 15.0+
- **iOS**: 17.0+ (for development)

## Quick Start

### Basic Import

```swift
import VisionUI
```

### Create Immersive Experience

```swift
@available(visionOS 1.0, *)
struct ImmersiveView: View {
    @StateObject private var immersiveManager = ImmersiveSpaceManager()
    
    var body: some View {
        RealityView { content in
            // Add immersive content
            let immersiveSpace = ImmersiveSpace(
                name: "Virtual Environment",
                type: .fullImmersive,
                environment: .office
            )
            
            content.add(immersiveSpace)
        }
        .onAppear {
            setupImmersiveExperience()
        }
    }
    
    private func setupImmersiveExperience() {
        let spaceConfig = ImmersiveSpaceConfiguration()
        spaceConfig.enableFullImmersive = true
        spaceConfig.enableSpatialAudio = true
        spaceConfig.enableEnvironmentalEffects = true
        
        immersiveManager.configure(spaceConfig)
    }
}
```

## Core Components

### ImmersiveSpaceManager

Manages immersive spaces and experiences.

```swift
@available(visionOS 1.0, *)
public class ImmersiveSpaceManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: ImmersiveSpaceConfiguration)
    
    public func addImmersiveSpace(_ space: ImmersiveSpace)
    
    public func addMixedRealitySpace(_ space: MixedRealitySpace)
    
    public func removeSpace(_ space: ImmersiveSpace)
    
    public func getCurrentSpace() -> ImmersiveSpace?
    
    public func transitionToSpace(_ space: ImmersiveSpace)
}
```

### ImmersiveSpaceConfiguration

Configuration for immersive experiences.

```swift
@available(visionOS 1.0, *)
public struct ImmersiveSpaceConfiguration {
    public var enableFullImmersive: Bool = true
    public var enableMixedReality: Bool = true
    public var enableSpatialAudio: Bool = true
    public var enableEnvironmentalEffects: Bool = true
    public var enableSpatialPhysics: Bool = true
    public var enableParticleSystems: Bool = true
    public var enableWeatherEffects: Bool = true
    public var enableTimeOfDay: Bool = true
}
```

## Immersive Spaces

### ImmersiveSpace

Represents a full immersive environment.

```swift
@available(visionOS 1.0, *)
public struct ImmersiveSpace {
    public let name: String
    public let type: ImmersiveType
    public let environment: EnvironmentType
    
    public enum ImmersiveType {
        case fullImmersive
        case mixedReality
        case augmentedReality
        case virtualReality
    }
    
    public enum EnvironmentType {
        case office
        case home
        case outdoor
        case fantasy
        case space
        case underwater
        case custom
    }
    
    public init(
        name: String,
        type: ImmersiveType,
        environment: EnvironmentType
    )
    
    public func configure(_ configuration: (ImmersiveSpaceConfiguration) -> Void) -> Self
}
```

### MixedRealitySpace

Represents a mixed reality environment.

```swift
@available(visionOS 1.0, *)
public struct MixedRealitySpace {
    public let name: String
    public let type: ImmersiveType
    public let environment: EnvironmentType
    
    public init(
        name: String,
        type: ImmersiveType,
        environment: EnvironmentType
    )
    
    public func configure(_ configuration: (MixedRealityConfiguration) -> Void) -> Self
}
```

### MixedRealityConfiguration

Configuration for mixed reality experiences.

```swift
@available(visionOS 1.0, *)
public struct MixedRealityConfiguration {
    public var enablePassthrough: Bool = true
    public var enableSpatialAnchoring: Bool = true
    public var enableObjectOcclusion: Bool = true
    public var enableLightingEstimation: Bool = true
    public var enablePlaneDetection: Bool = true
    public var enableObjectTracking: Bool = true
    public var enableSpatialMapping: Bool = true
}
```

## Spatial Audio

### SpatialAudioManager

Manages spatial audio in immersive environments.

```swift
@available(visionOS 1.0, *)
public class SpatialAudioManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: SpatialAudioConfiguration)
    
    public func addAudioSource(_ source: SpatialAudioSource)
    
    public func addEnvironmentalAudio(_ audio: EnvironmentalAudio)
    
    public func removeAudioSource(_ source: SpatialAudioSource)
    
    public func setMasterVolume(_ volume: Double)
    
    public func pauseAllAudio()
    
    public func resumeAllAudio()
}
```

### SpatialAudioConfiguration

Configuration for spatial audio.

```swift
@available(visionOS 1.0, *)
public struct SpatialAudioConfiguration {
    public var enable3DAudio: Bool = true
    public var enableSpatialReverb: Bool = true
    public var enableEnvironmentalAudio: Bool = true
    public var enableVoiceCommands: Bool = true
    public var enableDistanceAttenuation: Bool = true
    public var enableDopplerEffect: Bool = true
    public var enableHeadRelatedTransferFunction: Bool = true
}
```

### SpatialAudioSource

Represents a spatial audio source.

```swift
@available(visionOS 1.0, *)
public struct SpatialAudioSource {
    public let name: String
    public let position: SpatialPosition
    public let audioFile: String
    public let volume: Double
    public let pitch: Double
    
    public init(
        name: String,
        position: SpatialPosition,
        audioFile: String,
        volume: Double = 1.0,
        pitch: Double = 1.0
    )
    
    public func configure(_ configuration: (SpatialAudioSourceConfiguration) -> Void) -> Self
}
```

### SpatialAudioSourceConfiguration

Configuration for spatial audio sources.

```swift
@available(visionOS 1.0, *)
public struct SpatialAudioSourceConfiguration {
    public var enable3DPositioning: Bool = true
    public var enableDistanceAttenuation: Bool = true
    public var enableSpatialReverb: Bool = true
    public var enableLooping: Bool = false
    public var maxDistance: Double = 50.0
    public var minDistance: Double = 1.0
    public var rolloffFactor: Double = 1.0
}
```

### EnvironmentalAudio

Represents environmental audio in immersive spaces.

```swift
@available(visionOS 1.0, *)
public struct EnvironmentalAudio {
    public let environment: EnvironmentType
    public let intensity: Double
    
    public init(
        environment: EnvironmentType,
        intensity: Double = 1.0
    )
    
    public func configure(_ configuration: (EnvironmentalAudioConfiguration) -> Void) -> Self
}
```

### EnvironmentalAudioConfiguration

Configuration for environmental audio.

```swift
@available(visionOS 1.0, *)
public struct EnvironmentalAudioConfiguration {
    public var enableDynamicWeather: Bool = true
    public var enableTimeOfDay: Bool = true
    public var enableSpatialVariation: Bool = true
    public var enableUserInteraction: Bool = true
    public var enableAmbientSounds: Bool = true
    public var enableWeatherEffects: Bool = true
}
```

## Environmental Effects

### EnvironmentalEffectsManager

Manages environmental effects in immersive spaces.

```swift
@available(visionOS 1.0, *)
public class EnvironmentalEffectsManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: EnvironmentalEffectsConfiguration)
    
    public func addLightingEffect(_ effect: LightingEffect)
    
    public func addWeatherEffect(_ effect: WeatherEffect)
    
    public func addAtmosphericEffect(_ effect: AtmosphericEffect)
    
    public func updateEffects()
}
```

### EnvironmentalEffectsConfiguration

Configuration for environmental effects.

```swift
@available(visionOS 1.0, *)
public struct EnvironmentalEffectsConfiguration {
    public var enableLighting: Bool = true
    public var enableShadows: Bool = true
    public var enableAtmosphericEffects: Bool = true
    public var enableWeatherEffects: Bool = true
    public var enableFog: Bool = true
    public var enableWind: Bool = true
    public var enableParticles: Bool = true
}
```

### LightingEffect

Represents a lighting effect in immersive space.

```swift
@available(visionOS 1.0, *)
public struct LightingEffect {
    public let type: LightingType
    public let position: SpatialPosition
    public let intensity: Double
    public let color: SpatialColor
    
    public enum LightingType {
        case ambient
        case directional
        case point
        case spot
        case area
    }
    
    public init(
        type: LightingType,
        position: SpatialPosition,
        intensity: Double,
        color: SpatialColor
    )
}
```

### WeatherEffect

Represents a weather effect in immersive space.

```swift
@available(visionOS 1.0, *)
public struct WeatherEffect {
    public let type: WeatherType
    public let intensity: Double
    public let duration: TimeInterval
    
    public enum WeatherType {
        case rain
        case snow
        case fog
        case wind
        case storm
        case clear
    }
    
    public init(
        type: WeatherType,
        intensity: Double,
        duration: TimeInterval
    )
}
```

### AtmosphericEffect

Represents an atmospheric effect in immersive space.

```swift
@available(visionOS 1.0, *)
public struct AtmosphericEffect {
    public let type: AtmosphericType
    public let density: Double
    public let color: SpatialColor
    
    public enum AtmosphericType {
        case fog
        case haze
        case smoke
        case dust
        case mist
    }
    
    public init(
        type: AtmosphericType,
        density: Double,
        color: SpatialColor
    )
}
```

## Spatial Physics

### SpatialPhysicsManager

Manages physics simulation in immersive spaces.

```swift
@available(visionOS 1.0, *)
public class SpatialPhysicsManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: PhysicsConfiguration)
    
    public func addPhysicsObject(_ object: PhysicsObject)
    
    public func addPhysicsConstraint(_ constraint: PhysicsConstraint)
    
    public func updatePhysics()
    
    public func pausePhysics()
    
    public func resumePhysics()
}
```

### PhysicsConfiguration

Configuration for spatial physics.

```swift
@available(visionOS 1.0, *)
public struct PhysicsConfiguration {
    public var gravity: [Double] = [0, -9.8, 0]
    public var airResistance: Double = 0.1
    public var friction: Double = 0.8
    public var enableCollisionDetection: Bool = true
    public var enableRigidBodySimulation: Bool = true
    public var enableSoftBodySimulation: Bool = true
    public var enableFluidSimulation: Bool = false
}
```

### PhysicsObject

Represents a physics object in immersive space.

```swift
@available(visionOS 1.0, *)
public struct PhysicsObject {
    public let id: String
    public let position: SpatialPosition
    public let mass: Double
    public let shape: PhysicsShape
    
    public enum PhysicsShape {
        case box
        case sphere
        case cylinder
        case capsule
        case mesh
    }
    
    public init(
        id: String,
        position: SpatialPosition,
        mass: Double,
        shape: PhysicsShape
    )
}
```

### PhysicsConstraint

Represents a physics constraint between objects.

```swift
@available(visionOS 1.0, *)
public struct PhysicsConstraint {
    public let type: ConstraintType
    public let object1: PhysicsObject
    public let object2: PhysicsObject
    
    public enum ConstraintType {
        case fixed
        case hinge
        case spring
        case slider
        case cone
    }
    
    public init(
        type: ConstraintType,
        object1: PhysicsObject,
        object2: PhysicsObject
    )
}
```

## Spatial Particles

### ParticleSystemManager

Manages particle systems in immersive spaces.

```swift
@available(visionOS 1.0, *)
public class ParticleSystemManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: ParticleSystemConfiguration)
    
    public func addParticleSystem(_ system: ParticleSystem)
    
    public func removeParticleSystem(_ system: ParticleSystem)
    
    public func updateParticleSystems()
}
```

### ParticleSystemConfiguration

Configuration for particle systems.

```swift
@available(visionOS 1.0, *)
public struct ParticleSystemConfiguration {
    public var enableParticleSystems: Bool = true
    public var maxParticles: Int = 1000
    public var enableParticleCollision: Bool = true
    public var enableParticlePhysics: Bool = true
    public var enableParticleTrails: Bool = true
}
```

### ParticleSystem

Represents a particle system in immersive space.

```swift
@available(visionOS 1.0, *)
public struct ParticleSystem {
    public let name: String
    public let position: SpatialPosition
    public let particleType: ParticleType
    public let emissionRate: Double
    
    public enum ParticleType {
        case fire
        case smoke
        case sparkle
        case water
        case dust
        case magic
    }
    
    public init(
        name: String,
        position: SpatialPosition,
        particleType: ParticleType,
        emissionRate: Double
    )
    
    public func configure(_ configuration: (ParticleSystemConfiguration) -> Void) -> Self
}
```

### ParticleSystemConfiguration

Configuration for individual particle systems.

```swift
@available(visionOS 1.0, *)
public struct ParticleSystemConfiguration {
    public var enableEmission: Bool = true
    public var enableCollision: Bool = true
    public var enableTrails: Bool = true
    public var enablePhysics: Bool = true
    public var particleLifetime: TimeInterval = 5.0
    public var particleSpeed: Double = 1.0
    public var particleSize: Double = 0.1
}
```

## Spatial Weather

### WeatherSystemManager

Manages weather systems in immersive spaces.

```swift
@available(visionOS 1.0, *)
public class WeatherSystemManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: WeatherSystemConfiguration)
    
    public func setWeather(_ weather: WeatherType)
    
    public func setWeatherIntensity(_ intensity: Double)
    
    public func updateWeather()
}
```

### WeatherSystemConfiguration

Configuration for weather systems.

```swift
@available(visionOS 1.0, *)
public struct WeatherSystemConfiguration {
    public var enableDynamicWeather: Bool = true
    public var enableWeatherTransitions: Bool = true
    public var enableWeatherEffects: Bool = true
    public var enableWeatherAudio: Bool = true
    public var weatherCycleDuration: TimeInterval = 3600 // 1 hour
}
```

## Spatial Time

### TimeSystemManager

Manages time-based effects in immersive spaces.

```swift
@available(visionOS 1.0, *)
public class TimeSystemManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: TimeSystemConfiguration)
    
    public func setTimeOfDay(_ time: TimeOfDay)
    
    public func setDayNightCycle(_ enabled: Bool)
    
    public func updateTime()
}
```

### TimeSystemConfiguration

Configuration for time systems.

```swift
@available(visionOS 1.0, *)
public struct TimeSystemConfiguration {
    public var enableDayNightCycle: Bool = true
    public var enableTimeBasedLighting: Bool = true
    public var enableTimeBasedAudio: Bool = true
    public var cycleDuration: TimeInterval = 86400 // 24 hours
}
```

### TimeOfDay

Represents time of day in immersive space.

```swift
@available(visionOS 1.0, *)
public enum TimeOfDay {
    case dawn
    case morning
    case noon
    case afternoon
    case dusk
    case evening
    case night
    case midnight
}
```

## Spatial Events

### SpatialEventManager

Manages events in immersive spaces.

```swift
@available(visionOS 1.0, *)
public class SpatialEventManager: ObservableObject {
    public init()
    
    public func configure(_ configuration: SpatialEventConfiguration)
    
    public func addEvent(_ event: SpatialEvent)
    
    public func removeEvent(_ event: SpatialEvent)
    
    public func triggerEvent(_ event: SpatialEvent)
}
```

### SpatialEventConfiguration

Configuration for spatial events.

```swift
@available(visionOS 1.0, *)
public struct SpatialEventConfiguration {
    public var enableEventSystem: Bool = true
    public var enableEventTriggers: Bool = true
    public var enableEventAudio: Bool = true
    public var enableEventEffects: Bool = true
}
```

### SpatialEvent

Represents an event in immersive space.

```swift
@available(visionOS 1.0, *)
public struct SpatialEvent {
    public let id: String
    public let type: EventType
    public let position: SpatialPosition
    public let duration: TimeInterval
    
    public enum EventType {
        case explosion
        case teleport
        case transformation
        case interaction
        case environmental
    }
    
    public init(
        id: String,
        type: EventType,
        position: SpatialPosition,
        duration: TimeInterval
    )
}
```

## Configuration

### Global Configuration

```swift
// Configure immersive experiences globally
let immersiveConfig = ImmersiveExperienceConfiguration()
immersiveConfig.enableFullImmersive = true
immersiveConfig.enableMixedReality = true
immersiveConfig.enableSpatialAudio = true
immersiveConfig.enableEnvironmentalEffects = true
immersiveConfig.enableSpatialPhysics = true
immersiveConfig.enableParticleSystems = true
immersiveConfig.enableWeatherEffects = true
immersiveConfig.enableTimeOfDay = true

// Apply global configuration
ImmersiveExperience.configure(immersiveConfig)
```

### Space-Specific Configuration

```swift
// Configure specific immersive spaces
let spaceConfig = ImmersiveSpaceConfiguration()
spaceConfig.enableFullImmersive = true
spaceConfig.enableSpatialAudio = true
spaceConfig.enableEnvironmentalEffects = true
spaceConfig.enableSpatialPhysics = true

let audioConfig = SpatialAudioConfiguration()
audioConfig.enable3DAudio = true
audioConfig.enableSpatialReverb = true
audioConfig.enableEnvironmentalAudio = true
audioConfig.enableVoiceCommands = true

let physicsConfig = PhysicsConfiguration()
physicsConfig.gravity = [0, -9.8, 0]
physicsConfig.airResistance = 0.1
physicsConfig.friction = 0.8
physicsConfig.enableCollisionDetection = true
```

## Error Handling

### Error Types

```swift
public enum ImmersiveExperienceError: Error {
    case initializationFailed
    case configurationError
    case spaceCreationError
    case audioError
    case physicsError
    case particleError
    case weatherError
    case timeError
    case eventError
}
```

### Error Handling Example

```swift
// Handle immersive experience errors
do {
    let immersiveSpace = try ImmersiveSpace(
        name: "Virtual Office",
        type: .fullImmersive,
        environment: .office
    )
    
    immersiveSpace.configure { config in
        config.enableSpatialAudio = true
        config.enableEnvironmentalLighting = true
        config.enableWeatherEffects = true
        config.enableTimeOfDay = true
    }
    
} catch ImmersiveExperienceError.initializationFailed {
    print("❌ Immersive experience initialization failed")
} catch ImmersiveExperienceError.configurationError {
    print("❌ Configuration error")
} catch ImmersiveExperienceError.spaceCreationError {
    print("❌ Space creation failed")
} catch {
    print("❌ Unknown error: \(error)")
}
```

## Examples

### Complete Immersive Experience Example

```swift
import SwiftUI
import VisionUI

@available(visionOS 1.0, *)
struct ImmersiveExperienceExample: View {
    @StateObject private var immersiveManager = ImmersiveSpaceManager()
    @StateObject private var audioManager = SpatialAudioManager()
    @StateObject private var physicsManager = SpatialPhysicsManager()
    @StateObject private var particleManager = ParticleSystemManager()
    
    var body: some View {
        RealityView { content in
            // Add immersive content
            let immersiveSpace = ImmersiveSpace(
                name: "Virtual Environment",
                type: .fullImmersive,
                environment: .office
            )
            
            content.add(immersiveSpace)
        }
        .onAppear {
            setupImmersiveExperience()
        }
    }
    
    private func setupImmersiveExperience() {
        // Configure immersive space manager
        let spaceConfig = ImmersiveSpaceConfiguration()
        spaceConfig.enableFullImmersive = true
        spaceConfig.enableSpatialAudio = true
        spaceConfig.enableEnvironmentalEffects = true
        spaceConfig.enableSpatialPhysics = true
        spaceConfig.enableParticleSystems = true
        spaceConfig.enableWeatherEffects = true
        spaceConfig.enableTimeOfDay = true
        
        immersiveManager.configure(spaceConfig)
        
        // Configure audio manager
        let audioConfig = SpatialAudioConfiguration()
        audioConfig.enable3DAudio = true
        audioConfig.enableSpatialReverb = true
        audioConfig.enableEnvironmentalAudio = true
        audioConfig.enableVoiceCommands = true
        
        audioManager.configure(audioConfig)
        
        // Configure physics manager
        let physicsConfig = PhysicsConfiguration()
        physicsConfig.gravity = [0, -9.8, 0]
        physicsConfig.airResistance = 0.1
        physicsConfig.friction = 0.8
        physicsConfig.enableCollisionDetection = true
        
        physicsManager.configure(physicsConfig)
        
        // Configure particle manager
        let particleConfig = ParticleSystemConfiguration()
        particleConfig.enableParticleSystems = true
        particleConfig.maxParticles = 1000
        particleConfig.enableParticleCollision = true
        particleConfig.enableParticlePhysics = true
        
        particleManager.configure(particleConfig)
        
        // Create immersive space
        let immersiveSpace = ImmersiveSpace(
            name: "Virtual Office",
            type: .fullImmersive,
            environment: .office
        )
        
        immersiveSpace.configure { config in
            config.enableSpatialAudio = true
            config.enableEnvironmentalLighting = true
            config.enableWeatherEffects = true
            config.enableTimeOfDay = true
        }
        
        immersiveManager.addImmersiveSpace(immersiveSpace)
        
        // Add spatial audio source
        let audioSource = SpatialAudioSource(
            name: "Background Music",
            position: SpatialPosition(x: 0, y: 0, z: -5),
            audioFile: "background_music.wav"
        )
        
        audioSource.configure { config in
            config.enable3DPositioning = true
            config.enableDistanceAttenuation = true
            config.enableSpatialReverb = true
            config.enableLooping = true
        }
        
        audioManager.addAudioSource(audioSource)
        
        // Add environmental audio
        let environmentalAudio = EnvironmentalAudio(
            environment: .office,
            intensity: 0.7
        )
        
        environmentalAudio.configure { config in
            config.enableDynamicWeather = true
            config.enableTimeOfDay = true
            config.enableSpatialVariation = true
            config.enableUserInteraction = true
        }
        
        audioManager.addEnvironmentalAudio(environmentalAudio)
        
        // Add particle system
        let particleSystem = ParticleSystem(
            name: "Ambient Particles",
            position: SpatialPosition(x: 0, y: 2, z: -3),
            particleType: .dust,
            emissionRate: 10.0
        )
        
        particleSystem.configure { config in
            config.enableEmission = true
            config.enableCollision = true
            config.enableTrails = true
            config.enablePhysics = true
        }
        
        particleManager.addParticleSystem(particleSystem)
        
        print("✅ Immersive experience setup complete")
    }
}
```

This comprehensive Immersive Experiences API documentation provides all the necessary information for developers to create compelling immersive spatial computing experiences in VisionOS applications.
