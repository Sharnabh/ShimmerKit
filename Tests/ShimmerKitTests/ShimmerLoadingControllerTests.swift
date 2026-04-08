import XCTest
@testable import ShimmerKit

final class ShimmerLoadingControllerTests: XCTestCase {
    enum TestError: Error {
        case failed
    }

    @MainActor
    func testRunKeepsLoadingUntilTaskCompletes() async throws {
        let controller = ShimmerLoadingController()

        XCTAssertFalse(controller.isLoading)

        let value = try await controller.run {
            await MainActor.run {
                XCTAssertTrue(controller.isLoading)
            }
            try await Task.sleep(nanoseconds: 10_000_000)
            return 42
        }

        XCTAssertEqual(value, 42)
        XCTAssertFalse(controller.isLoading)
    }

    @MainActor
    func testRunResetsLoadingWhenTaskThrows() async {
        let controller = ShimmerLoadingController()

        do {
            _ = try await controller.run {
                throw TestError.failed
            }
            XCTFail("Expected error")
        } catch {
            XCTAssertEqual(error as? TestError, .failed)
        }

        XCTAssertFalse(controller.isLoading)
    }

    @MainActor
    func testTaskGroupKeepsLoadingUntilLastChildCompletes() async {
        let controller = ShimmerLoadingController()

        let total = await controller.runTaskGroup(of: Int.self, returning: Int.self) { group in
            for value in 1...3 {
                group.addTask {
                    value
                }
            }

            var sum = 0
            for await value in group {
                sum += value
            }

            XCTAssertTrue(controller.isLoading)
            return sum
        }

        XCTAssertEqual(total, 6)
        XCTAssertFalse(controller.isLoading)
    }
}
