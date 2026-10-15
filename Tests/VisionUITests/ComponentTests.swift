import CoreGraphics
import SwiftUI
import Testing
@testable import VisionUI

@Suite("Hit targets")
struct HitTargetTests {
    @Test("padding grows a small view to the minimum, centered")
    func growsSmallViews() {
        let insets = HitTarget.padding(toGrow: CGSize(width: 20, height: 30), to: 60)
        #expect(insets == EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
    }

    @Test("large views get no padding")
    func leavesLargeViews() {
        #expect(HitTarget.padding(toGrow: CGSize(width: 80, height: 100), to: 60) == EdgeInsets())
        #expect(HitTarget.padding(toGrow: CGSize(width: 80, height: 10), to: 44) == EdgeInsets(top: 17, leading: 0, bottom: 17, trailing: 0))
    }

    @Test("bad sizes and minimums count as zero")
    func hostileSizes() {
        for value: CGFloat in [.nan, .infinity, -.infinity, -5] {
            let grown = HitTarget.padding(toGrow: CGSize(width: value, height: value), to: 60)
            #expect(grown == EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
            #expect(HitTarget.padding(toGrow: CGSize(width: 10, height: 10), to: value) == EdgeInsets())
        }
    }

    @Test("huge minimums are capped at 10,000 points")
    func hugeMinimum() {
        // Without the cap, .greatestFiniteMagnitude gave about 9e307 points of padding.
        let side = HitTarget.largestMinimum / 2
        #expect(HitTarget.padding(toGrow: .zero, to: .greatestFiniteMagnitude) == EdgeInsets(top: side, leading: side, bottom: side, trailing: side))
        #expect(HitTarget.padding(toGrow: CGSize(width: 9_000, height: 20_000), to: 50_000) == EdgeInsets(top: 0, leading: 500, bottom: 0, trailing: 500))
    }

    @Test("the platform default follows Apple's guidelines")
    func platformDefault() {
        #if os(macOS)
        #expect(HitTarget.platformDefault == 28)
        #elseif os(visionOS)
        #expect(HitTarget.platformDefault == 60)
        #else
        #expect(HitTarget.platformDefault == 44)
        #endif
    }

    @Test("depth is limited to a finite, non-negative value")
    func depth() {
        #expect(SpatialDepthModifier.sanitized(24) == 24)
        #expect(SpatialDepthModifier.sanitized(-24) == 0)
        #expect(SpatialDepthModifier.sanitized(.nan) == 0)
        #expect(SpatialDepthModifier.sanitized(.infinity) == 0)
        #expect(SpatialDepthModifier.sanitized(1e9) == SpatialDepthModifier.maximumDepth)
    }
}
