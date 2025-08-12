import XCTest
@testable import VisionUI

final class VisionUIBasicTests: XCTestCase {
    func testInitializeDoesNotCrash() {
        VisionUI.initialize()
        XCTAssertTrue(true)
    }

    func testPerformanceMetricsAccessible() {
        let metrics = PerformanceMonitor.getPerformanceMetrics()
        XCTAssertGreaterThan(metrics.frameRate, 0)
    }
}
