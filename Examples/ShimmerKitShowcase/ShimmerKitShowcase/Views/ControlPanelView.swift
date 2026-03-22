import SwiftUI

struct ControlPanelView: View {
    @EnvironmentObject private var state: ShowcaseState

    var body: some View {
        Form {
            Section("Loading") {
                Toggle("isLoading", isOn: $state.isLoading)
                Picker("Profile", selection: $state.selectedProfile) {
                    ForEach(ProfileSelection.allCases) { profile in
                        Text(profile.title).tag(profile)
                    }
                }
            }

            Section("Custom Config") {
                Slider(value: $state.speed, in: 0.4...2.5) {
                    Text("Speed")
                }
                Text("Speed: \(state.speed, specifier: "%.2f")")

                Slider(value: $state.angle, in: 0...180) {
                    Text("Angle")
                }
                Text("Angle: \(state.angle, specifier: "%.0f")°")

                Slider(value: $state.shimmerOpacity, in: 0.1...0.8) {
                    Text("Shimmer Opacity")
                }
                Text("Shimmer Opacity: \(state.shimmerOpacity, specifier: "%.2f")")

                ColorPicker("Shimmer Color", selection: $state.shimmerColor)
                ColorPicker("Skeleton Color", selection: $state.skeletonColor)
            }

            Section("Feature Toggles") {
                Toggle("splitMultilineText", isOn: $state.splitMultilineText)
                Toggle("enableSemanticGrouping", isOn: $state.enableSemanticGrouping)
                Toggle("useLayoutProtocolIntegration", isOn: $state.useLayoutProtocolIntegration)
            }

            Section("Scope Filters") {
                Toggle("include header", isOn: $state.includeHeaderScope)
                Toggle("include body", isOn: $state.includeBodyScope)
                Toggle("include actions", isOn: $state.includeActionScope)
            }

            Section {
                Button("Reload fake data") {
                    Task {
                        await state.reloadData()
                    }
                }
            }
        }
        .navigationTitle("Controls")
    }
}
