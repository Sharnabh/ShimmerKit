import SwiftUI
import ShimmerKit

struct DemoWholeViewLoadingView: View {
    @EnvironmentObject private var loadingController: ShimmerLoadingController

    @State private var title: String = "Waiting for data"
    @State private var subtitle: String = "Tap one of the loaders to fetch content"
    @State private var stats: [String] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Whole view shimmer loading")
                    .font(.title2.bold())

                Text("Loading is controlled from the app root. This screen triggers work, but shimmer is rendered globally from home/navigation level.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Divider()

                    ForEach(stats, id: \.self) { item in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text(item)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                HStack(spacing: 12) {
                    Button("Load with Task") {
                        runSingleTaskLoad()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Load with TaskGroup") {
                        runTaskGroupLoad()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .navigationTitle("Whole View Loading")
        .task {
            guard stats.isEmpty else { return }
            runTaskGroupLoad()
        }
    }

    private func runSingleTaskLoad() {
        Task {
            do {
                let payload = try await loadingController.run {
                    // Simulate multiple sequential calls inside one Task block.
                    let user = try await fetchUser()
                    let permissions = try await fetchPermissions()
                    let feed = try await fetchFeed()

                    return (
                        title: "Loaded from one async task",
                        subtitle: "Loader ends after all sequential calls in the task complete.",
                        stats: [user, permissions, feed]
                    )
                }

                await MainActor.run {
                    title = payload.title
                    subtitle = payload.subtitle
                    stats = payload.stats
                }
            } catch {
                await MainActor.run {
                    title = "Load failed"
                    subtitle = "Single task request failed"
                    stats = []
                }
            }
        }
    }

    private func runTaskGroupLoad() {
        Task {
            let payload = await loadingController.runTaskGroup(of: String.self, returning: [String].self) { group in
                group.addTask {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    return "Header data ready"
                }
                group.addTask {
                    try? await Task.sleep(nanoseconds: 1_600_000_000)
                    return "Metrics data ready"
                }
                group.addTask {
                    try? await Task.sleep(nanoseconds: 2_100_000_000)
                    return "Recommendations ready"
                }

                var values: [String] = []
                for await value in group {
                    values.append(value)
                }
                return values.sorted()
            }

            await MainActor.run {
                title = "Loaded from TaskGroup"
                subtitle = "Shimmer stayed until the slowest child task completed."
                stats = payload
            }
        }
    }

    private func fetchUser() async throws -> String {
        try await Task.sleep(nanoseconds: 500_000_000)
        return "User profile loaded"
    }

    private func fetchPermissions() async throws -> String {
        try await Task.sleep(nanoseconds: 500_000_000)
        return "Permissions loaded"
    }

    private func fetchFeed() async throws -> String {
        try await Task.sleep(nanoseconds: 500_000_000)
        return "Feed loaded"
    }
}
