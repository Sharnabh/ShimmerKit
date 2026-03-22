import XCTest
@testable import ShimmerKit

final class ShimmerKitNodeUtilityTests: XCTestCase {
    func testSkeletonNodeIDIsStableForEquivalentNodesAndChangesWhenInputsDiffer() {
        let base = makeNode(
            frame: CGRect(x: 1, y: 2, width: 100, height: 20),
            kind: .text(lineHeight: 20),
            shapeStyle: .capsule,
            scope: "header"
        )
        let equivalent = makeNode(
            frame: CGRect(x: 1, y: 2, width: 100, height: 20),
            kind: .text(lineHeight: 20),
            shapeStyle: .capsule,
            scope: "header"
        )
        let differentScope = makeNode(
            frame: CGRect(x: 1, y: 2, width: 100, height: 20),
            kind: .text(lineHeight: 20),
            shapeStyle: .capsule,
            scope: "body"
        )

        XCTAssertEqual(base.id, equivalent.id)
        XCTAssertNotEqual(base.id, differentScope.id)
    }

    func testUtilityFrameValidationAndNearEqualityHelpers() {
        XCTAssertTrue(CGRect(x: 0, y: 0, width: 10, height: 10).isValidSkeletonFrame)
        XCTAssertFalse(CGRect(x: 0, y: 0, width: 4, height: 10).isValidSkeletonFrame)
        XCTAssertTrue(CGFloat(10.4).isAlmostEqual(to: 11.0, tolerance: 0.7))
        XCTAssertFalse(CGFloat(10.4).isAlmostEqual(to: 11.5, tolerance: 0.7))
    }
}
