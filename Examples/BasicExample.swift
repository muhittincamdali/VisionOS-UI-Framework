//
//  BasicExample.swift
//  VisionOS-UI-Framework
//
//  Created by Muhittin Camdali
//  Copyright © 2024 Muhittin Camdali. All rights reserved.
//

import SwiftUI
import VisionUI

/// Basic Example Application
/// 
/// Demonstrates basic usage of VisionUI framework components
/// including spatial containers, buttons, cards, and gestures.
@available(visionOS 1.0, *)
struct BasicExample: View {
    @State private var isModalPresented = false
    @State private var buttonTapCount = 0
    @State private var cardScale: Double = 1.0
    
    var body: some View {
        SpatialContainer {
            VStack(spacing: 20) {
                // Header
                Text("VisionOS UI Framework")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Basic Example")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                // Interactive Button
                SpatialButton("Tap Me (\(buttonTapCount))") {
                    buttonTapCount += 1
                }
                .spatialTap {
                    // Additional tap handling
                }
                
                // Interactive Card
                SpatialCard {
                    VStack(spacing: 12) {
                        Text("Interactive Card")
                            .font(.headline)
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.title)
                        
                        Text("This card responds to gestures")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .scaleEffect(cardScale)
                .spatialPinch(
                    onChanged: { value in
                        cardScale = value.scale
                    },
                    onEnded: { _ in
                        withAnimation(.spring()) {
                            cardScale = 1.0
                        }
                    }
                )
                
                // Navigation Example
                SpatialNavigation(title: "Example Navigation") {
                    VStack(spacing: 16) {
                        Text("Navigation Content")
                            .font(.title3)
                        
                        SpatialButton("Show Modal") {
                            isModalPresented = true
                        }
                        
                        SpatialButton("Reset Counter") {
                            buttonTapCount = 0
                        }
                        .spatialLongPress {
                            // Long press action
                        }
                    }
                }
                
                // Performance Monitor
                VStack(spacing: 8) {
                    Text("Performance Metrics")
                        .font(.headline)
                    
                    let metrics = PerformanceMonitor.getPerformanceMetrics()
                    
                    Text("Frame Rate: \(String(format: "%.1f", metrics.frameRate)) fps")
                        .font(.caption)
                    
                    Text("Memory Usage: \(String(format: "%.1f", metrics.memoryUsage)) MB")
                        .font(.caption)
                    
                    Text("Spatial Tracking: \(String(format: "%.2f", metrics.spatialTrackingQuality))")
                        .font(.caption)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .spatialModal(isPresented: $isModalPresented) {
            VStack(spacing: 16) {
                Text("Modal Example")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("This is a spatial modal dialog")
                    .font(.body)
                
                SpatialButton("Close") {
                    isModalPresented = false
                }
            }
        }
    }
}

#Preview {
    BasicExample()
} 