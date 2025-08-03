//
//  VisionUITests.swift
//  VisionOS-UI-Framework
//
//  Created by Muhittin Camdali
//  Copyright © 2024 Muhittin Camdali. All rights reserved.
//

import XCTest
import SwiftUI
@testable import VisionUI

@available(visionOS 1.0, *)
final class VisionUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Setup code before each test
    }
    
    override func tearDownWithError() throws {
        // Cleanup code after each test
    }
    
    // MARK: - Framework Tests
    
    func testFrameworkVersion() throws {
        XCTAssertEqual(VisionUI.version, "1.0.0")
        XCTAssertEqual(VisionUI.buildNumber, "1")
        XCTAssertEqual(VisionUI.identifier, "com.muhittincamdali.visionui")
    }
    
    func testFrameworkInitialization() throws {
        // Test framework initialization
        VisionUI.initialize()
        // Add assertions for initialization success
    }
    
    // MARK: - Spatial Environment Tests
    
    func testSpatialEnvironmentDefaults() throws {
        let lighting = SpatialEnvironment.defaultLighting
        let physics = SpatialEnvironment.defaultPhysics
        let audio = SpatialEnvironment.defaultAudio
        
        XCTAssertNotNil(lighting)
        XCTAssertNotNil(physics)
        XCTAssertNotNil(audio)
    }
    
    func testPhysicsConfiguration() throws {
        let physics = PhysicsConfiguration(
            gravity: [0, -9.8, 0],
            airResistance: 0.1,
            friction: 0.8
        )
        
        XCTAssertEqual(physics.gravity.count, 3)
        XCTAssertEqual(physics.airResistance, 0.1)
        XCTAssertEqual(physics.friction, 0.8)
    }
    
    func testSpatialLighting() throws {
        let lighting = SpatialLighting(
            primaryLight: .directional(color: .white, intensity: 1000, direction: [0, -1, 0]),
            ambientLight: .ambient(color: .white, intensity: 100)
        )
        
        XCTAssertNotNil(lighting.primaryLight)
        XCTAssertNotNil(lighting.ambientLight)
    }
    
    // MARK: - Performance Monitor Tests
    
    func testPerformanceMonitor() throws {
        let metrics = PerformanceMonitor.getPerformanceMetrics()
        
        XCTAssertGreaterThan(metrics.frameRate, 0)
        XCTAssertGreaterThan(metrics.memoryUsage, 0)
        XCTAssertGreaterThanOrEqual(metrics.spatialTrackingQuality, 0)
        XCTAssertLessThanOrEqual(metrics.spatialTrackingQuality, 1)
    }
    
    func testPerformanceMetrics() throws {
        let metrics = PerformanceMetrics(
            frameRate: 60.0,
            memoryUsage: 150.0,
            spatialTrackingQuality: 0.95,
            renderTime: 16.67,
            updateTime: 8.33
        )
        
        XCTAssertEqual(metrics.frameRate, 60.0)
        XCTAssertEqual(metrics.memoryUsage, 150.0)
        XCTAssertEqual(metrics.spatialTrackingQuality, 0.95)
        XCTAssertEqual(metrics.renderTime, 16.67)
        XCTAssertEqual(metrics.updateTime, 8.33)
    }
    
    // MARK: - Spatial Components Tests
    
    func testSpatialButtonStyle() throws {
        let primaryStyle = SpatialButtonStyle.primary
        let secondaryStyle = SpatialButtonStyle.secondary
        let successStyle = SpatialButtonStyle.success
        let dangerStyle = SpatialButtonStyle.danger
        
        XCTAssertNotNil(primaryStyle)
        XCTAssertNotNil(secondaryStyle)
        XCTAssertNotNil(successStyle)
        XCTAssertNotNil(dangerStyle)
    }
    
    func testSpatialCardStyle() throws {
        let defaultStyle = SpatialCardStyle.default
        let elevatedStyle = SpatialCardStyle.elevated
        
        XCTAssertNotNil(defaultStyle)
        XCTAssertNotNil(elevatedStyle)
    }
    
    func testSpatialListStyle() throws {
        let defaultStyle = SpatialListStyle.default
        let compactStyle = SpatialListStyle.compact
        
        XCTAssertNotNil(defaultStyle)
        XCTAssertNotNil(compactStyle)
    }
    
    func testSpatialModalStyle() throws {
        let defaultStyle = SpatialModalStyle.default
        let elevatedStyle = SpatialModalStyle.elevated
        
        XCTAssertNotNil(defaultStyle)
        XCTAssertNotNil(elevatedStyle)
    }
    
    // MARK: - Spatial Gestures Tests
    
    func testSpatialDragValue() throws {
        let dragValue = SpatialDragValue(
            translation: [1.0, 2.0, 3.0],
            velocity: [0.5, 1.0, 1.5],
            startLocation: [0.0, 0.0, 0.0],
            currentLocation: [1.0, 2.0, 3.0],
            distance: 3.7416573867739413
        )
        
        XCTAssertEqual(dragValue.translation.count, 3)
        XCTAssertEqual(dragValue.velocity.count, 3)
        XCTAssertEqual(dragValue.startLocation.count, 3)
        XCTAssertEqual(dragValue.currentLocation.count, 3)
        XCTAssertEqual(dragValue.distance, 3.7416573867739413, accuracy: 0.001)
    }
    
    func testSpatialPinchValue() throws {
        let pinchValue = SpatialPinchValue(
            scale: 1.5,
            velocity: 0.2,
            startScale: 1.0,
            currentScale: 1.5
        )
        
        XCTAssertEqual(pinchValue.scale, 1.5)
        XCTAssertEqual(pinchValue.velocity, 0.2)
        XCTAssertEqual(pinchValue.startScale, 1.0)
        XCTAssertEqual(pinchValue.currentScale, 1.5)
    }
    
    func testSpatialRotationValue() throws {
        let rotationValue = SpatialRotationValue(
            rotation: .pi,
            velocity: 0.1,
            startRotation: 0.0,
            currentRotation: .pi
        )
        
        XCTAssertEqual(rotationValue.rotation, .pi)
        XCTAssertEqual(rotationValue.velocity, 0.1)
        XCTAssertEqual(rotationValue.startRotation, 0.0)
        XCTAssertEqual(rotationValue.currentRotation, .pi)
    }
    
    func testSpatialHoverValue() throws {
        let hoverValue = SpatialHoverValue(
            location: [1.0, 2.0, 3.0],
            distance: 3.7416573867739413,
            velocity: [0.1, 0.2, 0.3]
        )
        
        XCTAssertEqual(hoverValue.location.count, 3)
        XCTAssertEqual(hoverValue.distance, 3.7416573867739413, accuracy: 0.001)
        XCTAssertEqual(hoverValue.velocity.count, 3)
    }
    
    // MARK: - Spatial Utilities Tests
    
    func testSpatialMath() throws {
        let point1 = [0.0, 0.0, 0.0]
        let point2 = [1.0, 1.0, 1.0]
        let distance = SpatialUtilities.SpatialMath.distance(from: point1, to: point2)
        
        XCTAssertEqual(distance, sqrt(3.0), accuracy: 0.001)
    }
    
    func testSpatialValidation() throws {
        let validPoint = [1.0, 2.0, 3.0]
        let invalidPoint = [1.0, 2.0] // Missing z coordinate
        
        XCTAssertTrue(SpatialUtilities.SpatialValidation.isValidPoint(validPoint))
        XCTAssertFalse(SpatialUtilities.SpatialValidation.isValidPoint(invalidPoint))
    }
    
    func testSpatialConversion() throws {
        let degrees = 180.0
        let radians = SpatialUtilities.SpatialConversion.degreesToRadians(degrees)
        
        XCTAssertEqual(radians, .pi, accuracy: 0.001)
    }
    
    func testSpatialFormatting() throws {
        let distance = 1.5
        let formatted = SpatialUtilities.SpatialFormatting.formatDistance(distance)
        
        XCTAssertEqual(formatted, "1.5 m")
    }
    
    // MARK: - Performance Tests
    
    func testPerformanceExample() throws {
        measure {
            // Performance test code
            let metrics = PerformanceMonitor.getPerformanceMetrics()
            XCTAssertNotNil(metrics)
        }
    }
    
    // MARK: - Memory Tests
    
    func testMemoryUsage() throws {
        let initialMemory = PerformanceMonitor.memoryUsage
        
        // Perform some operations
        let _ = SpatialUtilities.SpatialMath.magnitude([1.0, 2.0, 3.0])
        
        let finalMemory = PerformanceMonitor.memoryUsage
        
        // Memory usage should not increase significantly
        XCTAssertLessThan(finalMemory - initialMemory, 50.0)
    }
    
    // MARK: - Integration Tests
    
    func testFrameworkIntegration() throws {
        // Test that all framework components work together
        VisionUI.initialize()
        
        let metrics = PerformanceMonitor.getPerformanceMetrics()
        XCTAssertNotNil(metrics)
        
        let physics = SpatialEnvironment.defaultPhysics
        XCTAssertNotNil(physics)
        
        let lighting = SpatialEnvironment.defaultLighting
        XCTAssertNotNil(lighting)
    }
} 