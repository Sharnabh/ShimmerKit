import SwiftUI
import ShimmerKit

struct DemoProfilesView: View {
    @EnvironmentObject private var state: ShowcaseState

    private var gradientConfig: ShimmerConfig {
        ShimmerConfig(
            gradient: Gradient(colors: [.clear, .orange.opacity(0.45), .clear]),
            skeletonColor: .orange.opacity(0.18),
            speed: 0.9,
            angle: .degrees(40),
            splitMultilineText: true,
            enableSemanticGrouping: true,
            useLayoutProtocolIntegration: false
        )
    }

    private var colorConfig: ShimmerConfig {
        ShimmerConfig(
            shimmerColor: .teal,
            skeletonColor: .teal.opacity(0.18),
            shimmerOpacity: 0.45,
            speed: 1.0,
            angle: .degrees(28),
            splitMultilineText: true,
            enableSemanticGrouping: true,
            useLayoutProtocolIntegration: true
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                GroupBox("ShimmerKit.defaultConfig") {
                    profileCard(title: "Default Config")
                        .smartSkeleton(state.isLoading, config: ShimmerKit.defaultConfig)
                }

                GroupBox("ShimmerKit.config(_ profile:)") {
                    VStack(alignment: .leading, spacing: 10) {
                        profileCard(title: ".default")
                            .smartSkeleton(state.isLoading, config: ShimmerKit.config(.default))
                        profileCard(title: ".subtle")
                            .smartSkeleton(state.isLoading, config: ShimmerKit.config(.subtle))
                        profileCard(title: ".feedLoading")
                            .smartSkeleton(state.isLoading, config: ShimmerKit.config(.feedLoading))
                        profileCard(title: ".detailPage")
                            .smartSkeleton(state.isLoading, config: ShimmerKit.config(.detailPage))
                    }
                }

                GroupBox("ShimmerConfig initializers") {
                    VStack(alignment: .leading, spacing: 10) {
                        profileCard(title: "init(gradient: ...)")
                            .smartSkeleton(state.isLoading, config: gradientConfig)
                        profileCard(title: "init(shimmerColor: ...)")
                            .smartSkeleton(state.isLoading, config: colorConfig)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Profiles & Config")
        .toolbar {
            NavigationLink("Controls") { ControlPanelView() }
        }
    }

    @ViewBuilder
    private func profileCard(title: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .skeletonNode(kind: .text(lineHeight: 18))
            Text("Configuration preview")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .skeletonNode(kind: .text(lineHeight: 14))
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 48)
                .skeletonNode(kind: .generic)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
