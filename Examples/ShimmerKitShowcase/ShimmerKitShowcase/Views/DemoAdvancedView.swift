import SwiftUI
import ShimmerKit

struct DemoAdvancedView: View {
    @EnvironmentObject private var state: ShowcaseState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("This view is designed to make multiline splitting and semantic grouping visible.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Large headline placeholder area")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .skeletonNode(kind: .text(lineHeight: 26))

                    Text("This is intentionally a long subtitle line used to demonstrate line splitting behavior while loading.")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .skeletonNode(kind: .text(lineHeight: 16))

                    Text("Another long line for subtitle grouping and width adjustment heuristics.")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .skeletonNode(kind: .text(lineHeight: 16))
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .smartSkeleton(state.isLoading, config: state.currentConfig())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Current toggles")
                        .font(.headline)
                    Text("splitMultilineText: \(state.splitMultilineText.description)")
                    Text("enableSemanticGrouping: \(state.enableSemanticGrouping.description)")
                    Text("useLayoutProtocolIntegration: \(state.useLayoutProtocolIntegration.description)")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle("Advanced Toggles")
        .toolbar {
            NavigationLink("Controls") { ControlPanelView() }
        }
    }
}
