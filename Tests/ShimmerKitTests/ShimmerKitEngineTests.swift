import XCTest
@testable import ShimmerKit

final class ShimmerKitEngineTests: XCTestCase {
    func testHeuristicsInferKindsFromFrameGeometry() {
        let textKind = SkeletonHeuristics.inferKind(from: CGRect(x: 0, y: 0, width: 120, height: 14))
        let imageKind = SkeletonHeuristics.inferKind(from: CGRect(x: 0, y: 0, width: 48, height: 47.2))
        let genericKind = SkeletonHeuristics.inferKind(from: CGRect(x: 0, y: 0, width: 120, height: 36))

        if case .text(let lineHeight) = textKind {
            XCTAssertEqual(lineHeight, 14)
        } else {
            XCTFail("Expected text kind")
        }

        XCTAssertEqual(imageKind, .image)
        XCTAssertEqual(genericKind, .generic)
    }

    func testHeuristicsResolveCornerRadiusAndShapeStyles() {
        XCTAssertEqual(SkeletonHeuristics.defaultCornerRadius(for: .text(lineHeight: 18)), 9)
        XCTAssertEqual(SkeletonHeuristics.defaultCornerRadius(for: .image), 12)
        XCTAssertEqual(SkeletonHeuristics.defaultCornerRadius(for: .generic), 8)

        XCTAssertEqual(
            SkeletonHeuristics.defaultShapeStyle(for: .text(lineHeight: 14), cornerRadius: 7),
            .capsule
        )
        XCTAssertEqual(
            SkeletonHeuristics.defaultShapeStyle(for: .generic, cornerRadius: 10),
            .roundedRectangle(cornerRadius: 10)
        )

        XCTAssertEqual(
            SkeletonHeuristics.resolveShapeStyle(preferred: .automatic, kind: .image, cornerRadius: 12),
            .roundedRectangle(cornerRadius: 12)
        )
        XCTAssertEqual(
            SkeletonHeuristics.resolveShapeStyle(preferred: .circle, kind: .generic, cornerRadius: 8),
            .circle
        )
    }

    func testProcessorRemovesInvalidFramesAndMergesIntersectingNodes() {
        let validA = makeNode(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let validB = makeNode(frame: CGRect(x: 20, y: 8, width: 30, height: 20))
        let invalid = makeNode(frame: CGRect(x: 0, y: 0, width: 3, height: 20))

        let processed = SkeletonProcessor.process([validA, invalid, validB])

        XCTAssertEqual(processed.count, 1)
        XCTAssertEqual(processed[0].frame, CGRect(x: 0, y: 0, width: 50, height: 28))
    }

    func testGroupingWithoutSplitRoundsTextCornerRadius() {
        let text = makeNode(
            frame: CGRect(x: 0, y: 0, width: 140, height: 14),
            cornerRadius: 0,
            kind: .text(lineHeight: 14)
        )

        let grouped = SkeletonGrouping.groupTextLines([text], splitMultilineText: false, enableSemanticGrouping: false)

        XCTAssertEqual(grouped.count, 1)
        XCTAssertEqual(grouped[0].cornerRadius, 7)
        XCTAssertEqual(grouped[0].frame, text.frame)
    }

    func testGroupingWithSplitCreatesMultipleLinesAndShortensLastLine() {
        let text = makeNode(
            frame: CGRect(x: 0, y: 0, width: 200, height: 40),
            cornerRadius: 0,
            kind: .text(lineHeight: 10)
        )

        let grouped = SkeletonGrouping.groupTextLines([text], splitMultilineText: true, enableSemanticGrouping: false)

        XCTAssertGreaterThan(grouped.count, 1)
        XCTAssertEqual(grouped[0].frame.height, 10, accuracy: 0.000_001)

        let lastLine = grouped[grouped.count - 1]
        XCTAssertLessThan(lastLine.frame.width, grouped[0].frame.width)
        XCTAssertEqual(lastLine.frame.width, 144, accuracy: 0.000_001)
        XCTAssertEqual(lastLine.cornerRadius, 5, accuracy: 0.000_001)
    }

    func testSemanticGroupingShrinksBodyTextWidthOnly() {
        let body = makeNode(
            frame: CGRect(x: 0, y: 0, width: 100, height: 10),
            kind: .text(lineHeight: 10)
        )
        let title = makeNode(
            frame: CGRect(x: 0, y: 20, width: 100, height: 20),
            kind: .text(lineHeight: 20)
        )
        let image = makeNode(
            frame: CGRect(x: 0, y: 50, width: 30, height: 30),
            kind: .image
        )

        let grouped = SkeletonGrouping.groupTextLines(
            [body, title, image],
            splitMultilineText: false,
            enableSemanticGrouping: true
        )

        XCTAssertEqual(grouped.count, 3)
        XCTAssertEqual(grouped[0].frame.width, 90, accuracy: 0.000_001)
        XCTAssertEqual(grouped[1].frame.width, 100, accuracy: 0.000_001)
        XCTAssertEqual(grouped[2].frame.width, 30, accuracy: 0.000_001)
    }
}
