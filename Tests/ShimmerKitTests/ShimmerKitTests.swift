import XCTest
@testable import ShimmerKit

final class ShimmerKitConfigTests: XCTestCase {
    func testDefaultProfileReturnsExpectedBaseValues() {
        let config = ShimmerKit.config(.default)

        XCTAssertEqual(config.speed, 1.2)
        XCTAssertEqual(config.angle.degrees, 20)
        XCTAssertFalse(config.splitMultilineText)
        XCTAssertFalse(config.enableSemanticGrouping)
        XCTAssertFalse(config.useLayoutProtocolIntegration)
    }

    func testPresetProfilesExposeExpectedBehaviorFlags() {
        let subtle = ShimmerKit.config(.subtle)
        XCTAssertEqual(subtle.speed, 1.35)
        XCTAssertEqual(subtle.angle.degrees, 16, accuracy: 0.000_001)
        XCTAssertFalse(subtle.splitMultilineText)
        XCTAssertFalse(subtle.enableSemanticGrouping)
        XCTAssertFalse(subtle.useLayoutProtocolIntegration)

        let feed = ShimmerKit.config(.feedLoading)
        XCTAssertEqual(feed.speed, 1.0)
        XCTAssertEqual(feed.angle.degrees, 30, accuracy: 0.000_001)
        XCTAssertTrue(feed.splitMultilineText)
        XCTAssertTrue(feed.enableSemanticGrouping)
        XCTAssertFalse(feed.useLayoutProtocolIntegration)

        let detail = ShimmerKit.config(.detailPage)
        XCTAssertEqual(detail.speed, 0.9)
        XCTAssertEqual(detail.angle.degrees, 38, accuracy: 0.000_001)
        XCTAssertTrue(detail.splitMultilineText)
        XCTAssertTrue(detail.enableSemanticGrouping)
        XCTAssertTrue(detail.useLayoutProtocolIntegration)
    }

    func testCustomConfigOverloadsPreserveProvidedValues() {
        let direct = ShimmerKit.config(
            speed: 2.1,
            angle: .degrees(45),
            splitMultilineText: true,
            enableSemanticGrouping: true,
            useLayoutProtocolIntegration: true
        )
        XCTAssertEqual(direct.speed, 2.1)
        XCTAssertEqual(direct.angle.degrees, 45, accuracy: 0.000_001)
        XCTAssertTrue(direct.splitMultilineText)
        XCTAssertTrue(direct.enableSemanticGrouping)
        XCTAssertTrue(direct.useLayoutProtocolIntegration)

        let colorBased = ShimmerKit.config(
            shimmerColor: .blue,
            shimmerOpacity: 0.42,
            speed: 1.8,
            angle: .degrees(12),
            splitMultilineText: true,
            enableSemanticGrouping: false,
            useLayoutProtocolIntegration: true
        )
        XCTAssertEqual(colorBased.speed, 1.8)
        XCTAssertEqual(colorBased.angle.degrees, 12, accuracy: 0.000_001)
        XCTAssertTrue(colorBased.splitMultilineText)
        XCTAssertFalse(colorBased.enableSemanticGrouping)
        XCTAssertTrue(colorBased.useLayoutProtocolIntegration)
    }

    func testShimmerPhaseRemainsNormalizedAndRepeatsEverySpeedInterval() {
        let start = Date(timeIntervalSinceReferenceDate: 1_000)
        let speed = 1.25

        let phase1 = ShimmerPhase.value(date: start, speed: speed)
        let phase2 = ShimmerPhase.value(date: start.addingTimeInterval(speed), speed: speed)

        XCTAssertGreaterThanOrEqual(phase1, 0)
        XCTAssertLessThan(phase1, 1)
        XCTAssertEqual(phase1, phase2, accuracy: 0.000_001)
    }
}
