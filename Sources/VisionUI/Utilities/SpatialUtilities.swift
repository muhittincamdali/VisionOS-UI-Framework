//
//  SpatialUtilities.swift
//  VisionOS-UI-Framework
//
//  Created by Muhittin Camdali
//  Copyright © 2024 Muhittin Camdali. All rights reserved.
//

import SwiftUI
import RealityKit
import Spatial

/// Spatial Utilities for VisionOS
@available(visionOS 1.0, *)
public struct SpatialUtilities {
    
    /// Spatial math utilities
    public struct SpatialMath {
        
        /// Calculate distance between two 3D points
        public static func distance(from point1: [Double], to point2: [Double]) -> Double {
            guard point1.count == 3, point2.count == 3 else { return 0 }
            let dx = point1[0] - point2[0]
            let dy = point1[1] - point2[1]
            let dz = point1[2] - point2[2]
            return sqrt(dx * dx + dy * dy + dz * dz)
        }
        
        /// Calculate magnitude of a 3D vector
        public static func magnitude(_ vector: [Double]) -> Double {
            guard vector.count == 3 else { return 0 }
            return sqrt(vector[0] * vector[0] + vector[1] * vector[1] + vector[2] * vector[2])
        }
        
        /// Normalize a 3D vector
        public static func normalize(_ vector: [Double]) -> [Double] {
            let mag = magnitude(vector)
            guard mag > 0 else { return [0, 0, 0] }
            return [vector[0] / mag, vector[1] / mag, vector[2] / mag]
        }
        
        /// Calculate dot product of two 3D vectors
        public static func dotProduct(_ vector1: [Double], _ vector2: [Double]) -> Double {
            guard vector1.count == 3, vector2.count == 3 else { return 0 }
            return vector1[0] * vector2[0] + vector1[1] * vector2[1] + vector1[2] * vector2[2]
        }
        
        /// Calculate cross product of two 3D vectors
        public static func crossProduct(_ vector1: [Double], _ vector2: [Double]) -> [Double] {
            guard vector1.count == 3, vector2.count == 3 else { return [0, 0, 0] }
            return [
                vector1[1] * vector2[2] - vector1[2] * vector2[1],
                vector1[2] * vector2[0] - vector1[0] * vector2[2],
                vector1[0] * vector2[1] - vector1[1] * vector2[0]
            ]
        }
    }
    
    /// Spatial animation utilities
    public struct SpatialAnimation {
        
        /// Smooth animation curve for spatial interactions
        public static let smooth = Animation.easeInOut(duration: 0.3)
        
        /// Quick animation curve for responsive feedback
        public static let quick = Animation.easeOut(duration: 0.15)
        
        /// Slow animation curve for dramatic effects
        public static let slow = Animation.easeInOut(duration: 0.6)
        
        /// Spring animation for natural movement
        public static let spring = Animation.spring(response: 0.5, dampingFraction: 0.8)
        
        /// Bounce animation for playful interactions
        public static let bounce = Animation.interpolatingSpring(stiffness: 100, damping: 10)
    }
    
    /// Spatial color utilities
    public struct SpatialColors {
        
        /// Primary spatial blue
        public static let primaryBlue = Color(red: 0.2, green: 0.6, blue: 1.0)
        
        /// Secondary spatial gray
        public static let secondaryGray = Color(red: 0.8, green: 0.8, blue: 0.8)
        
        /// Success green
        public static let successGreen = Color(red: 0.2, green: 0.8, blue: 0.2)
        
        /// Warning orange
        public static let warningOrange = Color(red: 1.0, green: 0.6, blue: 0.2)
        
        /// Error red
        public static let errorRed = Color(red: 1.0, green: 0.2, blue: 0.2)
        
        /// Spatial background
        public static let spatialBackground = Color(red: 0.1, green: 0.1, blue: 0.1)
        
        /// Spatial surface
        public static let spatialSurface = Color(red: 0.2, green: 0.2, blue: 0.2)
    }
    
    /// Spatial dimension utilities
    public struct SpatialDimensions {
        
        /// Standard button height
        public static let buttonHeight: CGFloat = 44
        
        /// Standard card padding
        public static let cardPadding: CGFloat = 16
        
        /// Standard corner radius
        public static let cornerRadius: CGFloat = 12
        
        /// Standard shadow radius
        public static let shadowRadius: CGFloat = 8
        
        /// Standard spacing
        public static let spacing: CGFloat = 8
        
        /// Large spacing
        public static let largeSpacing: CGFloat = 16
        
        /// Extra large spacing
        public static let extraLargeSpacing: CGFloat = 24
    }
    
    /// Spatial validation utilities
    public struct SpatialValidation {
        
        /// Validate 3D point coordinates
        public static func isValidPoint(_ point: [Double]) -> Bool {
            return point.count == 3 && 
                   point.allSatisfy { $0.isFinite && !$0.isNaN }
        }
        
        /// Validate 3D vector
        public static func isValidVector(_ vector: [Double]) -> Bool {
            return vector.count == 3 && 
                   vector.allSatisfy { $0.isFinite && !$0.isNaN }
        }
        
        /// Validate distance range
        public static func isValidDistance(_ distance: Double, min: Double = 0, max: Double = 100) -> Bool {
            return distance >= min && distance <= max && distance.isFinite && !distance.isNaN
        }
        
        /// Validate scale factor
        public static func isValidScale(_ scale: Double, min: Double = 0.1, max: Double = 10.0) -> Bool {
            return scale >= min && scale <= max && scale.isFinite && !scale.isNaN
        }
    }
    
    /// Spatial conversion utilities
    public struct SpatialConversion {
        
        /// Convert degrees to radians
        public static func degreesToRadians(_ degrees: Double) -> Double {
            return degrees * .pi / 180.0
        }
        
        /// Convert radians to degrees
        public static func radiansToDegrees(_ radians: Double) -> Double {
            return radians * 180.0 / .pi
        }
        
        /// Convert meters to centimeters
        public static func metersToCentimeters(_ meters: Double) -> Double {
            return meters * 100.0
        }
        
        /// Convert centimeters to meters
        public static func centimetersToMeters(_ centimeters: Double) -> Double {
            return centimeters / 100.0
        }
        
        /// Convert inches to meters
        public static func inchesToMeters(_ inches: Double) -> Double {
            return inches * 0.0254
        }
        
        /// Convert meters to inches
        public static func metersToInches(_ meters: Double) -> Double {
            return meters / 0.0254
        }
    }
    
    /// Spatial formatting utilities
    public struct SpatialFormatting {
        
        /// Format distance with appropriate units
        public static func formatDistance(_ distance: Double) -> String {
            if distance < 1.0 {
                return String(format: "%.1f cm", distance * 100)
            } else if distance < 1000.0 {
                return String(format: "%.1f m", distance)
            } else {
                return String(format: "%.1f km", distance / 1000)
            }
        }
        
        /// Format angle in degrees
        public static func formatAngle(_ angle: Double) -> String {
            return String(format: "%.1f°", angle)
        }
        
        /// Format scale factor
        public static func formatScale(_ scale: Double) -> String {
            return String(format: "%.2fx", scale)
        }
        
        /// Format 3D coordinates
        public static func formatCoordinates(_ coordinates: [Double]) -> String {
            guard coordinates.count == 3 else { return "Invalid coordinates" }
            return String(format: "(%.2f, %.2f, %.2f)", coordinates[0], coordinates[1], coordinates[2])
        }
    }
    
    /// Spatial debugging utilities
    public struct SpatialDebug {
        
        /// Print spatial debug information
        public static func printDebug(_ message: String, category: String = "Spatial") {
            #if DEBUG
            print("[\(category)] \(message)")
            #endif
        }
        
        /// Log spatial performance metrics
        public static func logPerformance(_ metrics: PerformanceMetrics) {
            #if DEBUG
            print("[Performance] Frame Rate: \(metrics.frameRate) fps")
            print("[Performance] Memory Usage: \(metrics.memoryUsage) MB")
            print("[Performance] Spatial Tracking: \(metrics.spatialTrackingQuality)")
            #endif
        }
        
        /// Validate spatial environment
        public static func validateEnvironment() -> Bool {
            // Add environment validation logic here
            return true
        }
    }
}

// MARK: - Extensions

@available(visionOS 1.0, *)
public extension Array where Element == Double {
    
    /// Calculate magnitude of the array as a 3D vector
    var magnitude: Double {
        return SpatialUtilities.SpatialMath.magnitude(self)
    }
    
    /// Normalize the array as a 3D vector
    var normalized: [Double] {
        return SpatialUtilities.SpatialMath.normalize(self)
    }
    
    /// Check if the array is a valid 3D point
    var isValidPoint: Bool {
        return SpatialUtilities.SpatialValidation.isValidPoint(self)
    }
    
    /// Check if the array is a valid 3D vector
    var isValidVector: Bool {
        return SpatialUtilities.SpatialValidation.isValidVector(self)
    }
}

@available(visionOS 1.0, *)
public extension Double {
    
    /// Convert to radians
    var radians: Double {
        return SpatialUtilities.SpatialConversion.degreesToRadians(self)
    }
    
    /// Convert to degrees
    var degrees: Double {
        return SpatialUtilities.SpatialConversion.radiansToDegrees(self)
    }
    
    /// Convert meters to centimeters
    var centimeters: Double {
        return SpatialUtilities.SpatialConversion.metersToCentimeters(self)
    }
    
    /// Convert centimeters to meters
    var meters: Double {
        return SpatialUtilities.SpatialConversion.centimetersToMeters(self)
    }
    
    /// Convert inches to meters
    var metersFromInches: Double {
        return SpatialUtilities.SpatialConversion.inchesToMeters(self)
    }
    
    /// Convert meters to inches
    var inchesFromMeters: Double {
        return SpatialUtilities.SpatialConversion.metersToInches(self)
    }
} 