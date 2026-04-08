//
//  ShimmerLoadingController.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 08/04/26.
//

import SwiftUI

@MainActor
public final class ShimmerLoadingController: ObservableObject {
    @Published private var activeOperations: Int

    public var isLoading: Bool {
        activeOperations > 0
    }

    public init(isLoading: Bool = false) {
        self.activeOperations = isLoading ? 1 : 0
    }

    public func beginLoading() {
        activeOperations += 1
    }

    public func endLoading() {
        activeOperations = max(0, activeOperations - 1)
    }

    public func run<T>(_ operation: @Sendable () async throws -> T) async rethrows -> T {
        beginLoading()
        defer { endLoading() }
        return try await operation()
    }

    public func runTaskGroup<ChildTaskResult: Sendable, GroupResult>(
        of childTaskResultType: ChildTaskResult.Type = ChildTaskResult.self,
        returning returnType: GroupResult.Type = GroupResult.self,
        body: (inout TaskGroup<ChildTaskResult>) async -> GroupResult
    ) async -> GroupResult {
        beginLoading()
        defer { endLoading() }
        return await withTaskGroup(of: childTaskResultType, returning: returnType, body: body)
    }

    public func runThrowingTaskGroup<ChildTaskResult: Sendable, GroupResult>(
        of childTaskResultType: ChildTaskResult.Type = ChildTaskResult.self,
        returning returnType: GroupResult.Type = GroupResult.self,
        body: (inout ThrowingTaskGroup<ChildTaskResult, any Error>) async throws -> GroupResult
    ) async throws -> GroupResult {
        beginLoading()
        defer { endLoading() }
        return try await withThrowingTaskGroup(of: childTaskResultType, returning: returnType, body: body)
    }
}
