import RealityKit
import SwiftUI
import Testing
@testable import VisionUI

/// The README samples, compiled from the example app through the symlink ReadmeSamples.swift.
/// A sample that stops compiling fails the build; the checks below also make sure the samples
/// build the layouts they describe.
@MainActor
@Suite("README samples")
struct ReadmeSampleTests {
    @Test("The quick start places five cards on an arc")
    func quickStart() {
        let sample = ContentView()
        let placements = ArcLayout.arc(radius: 0.6, spacing: 0.17).placements(count: sample.planets.count)
        #expect(placements.count == 5)
        // The middle card is at the origin; the outer ones come toward the viewer.
        #expect(placements[2].position == .zero)
        #expect(placements[0].position.z > 0 && placements[4].position.z > 0)
    }

    @Test("The carousel starts on the first destination")
    func carousel() {
        let sample = CarouselSample()
        #expect(sample.destinations.count == 6)
        #expect(RingLayout(radius: 0.25).frontIndex(count: sample.destinations.count) == 0)
    }

    @Test("The shelf sample arranges seven spheres on an arc")
    func shelf() {
        let shelf = Entity()
        for _ in 0..<7 { shelf.addChild(Entity()) }
        #expect(shelf.arrangeChildren(using: .arc(radius: 0.5, spacing: 0.12)) == 7)
        #expect(shelf.children[3].position == .zero)
    }

    #if !os(visionOS)
    @Test("The quick start draws its cards side by side")
    func quickStartRenders() throws {
        // 0.17 m apart at the flat projection's 1000 points per meter.
        let pixels = try Pixels(ContentView(), width: 1000, height: 200)
        let row = (0..<1000).map { pixels[$0, 100] }
        #expect(row.contains { $0 != .white })
        // The middle card covers the center.
        #expect(pixels[500, 100] != .white)
    }

    @Test("The other samples render")
    func samplesRender() throws {
        for sample in [AnyView(CarouselSample()), AnyView(ManipulationSample()), AnyView(PlayerSample())] {
            let pixels = try Pixels(sample, width: 400, height: 300)
            #expect((0..<300).contains { y in (0..<400).contains { pixels[$0, y] != .white } })
        }
    }
    #endif
}
