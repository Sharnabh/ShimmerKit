import SwiftUI
import ShimmerKit

struct DemoScopedPartialView: View {
    @EnvironmentObject private var state: ShowcaseState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Toggle included scopes from Controls to test includeScopes filtering.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Orders")
                        .font(.title3.bold())
                        .skeletonNode(scope: "header")

                    Text("Your orders are syncing with server")
                        .font(.subheadline)
                        .skeletonNode(scope: "body")

                    Text("Estimated completion: 2 minutes")
                        .font(.subheadline)
                        .skeletonNode(scope: "body")

                    HStack(spacing: 12) {
                        Button("Retry") {}
                            .buttonStyle(.borderedProminent)
                            .skeletonNode(kind: .generic, scope: "actions")

                        Button("Cancel") {}
                            .buttonStyle(.bordered)
                            .skeletonNode(kind: .generic, scope: "actions")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .smartSkeleton(
                    state.isLoading,
                    config: state.currentConfig(),
                    includeScopes: state.includedScopes
                )
            }
            .padding()
        }
        .navigationTitle("Partial Scopes")
        .toolbar {
            NavigationLink("Controls") { ControlPanelView() }
        }
    }
}
