import SwiftUI
import ShimmerKit

struct DemoBasicView: View {
    @EnvironmentObject private var state: ShowcaseState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("This screen demonstrates smartSkeleton(isLoading) with shared custom config.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 10) {
                    Text("MacBook Pro 14")
                        .font(.headline)
                        .skeletonNode()

                    Text("M4 Pro · 18GB · 512GB")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .skeletonNode()

                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.15))
                        .frame(height: 140)
                        .skeletonNode()
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .smartSkeleton(state.isLoading, config: state.currentConfig())
            }
            .padding()
        }
        .navigationTitle("Basic")
        .toolbar {
            NavigationLink("Controls") { ControlPanelView() }
        }
    }
}
