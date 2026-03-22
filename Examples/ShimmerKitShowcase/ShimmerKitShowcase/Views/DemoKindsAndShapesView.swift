import SwiftUI
import ShimmerKit

struct DemoKindsAndShapesView: View {
    @EnvironmentObject private var state: ShowcaseState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                GroupBox("Kinds") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Text kind")
                            .skeletonNode(kind: .text(lineHeight: 18))

                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 56, height: 56)
                            .skeletonNode(kind: .image)

                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 70)
                            .skeletonNode(kind: .generic)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                }

                GroupBox("Shapes") {
                    VStack(alignment: .leading, spacing: 10) {
                        Circle()
                            .frame(width: 44, height: 44)
                            .skeletonNode(shape: .circle)

                        Text("Capsule shape")
                            .skeletonNode(kind: .text(lineHeight: 16), shape: .capsule)

                        RoundedRectangle(cornerRadius: 4)
                            .frame(height: 52)
                            .skeletonNode(shape: .roundedRectangle(cornerRadius: 14))

                        Text("Automatic shape")
                            .skeletonNode(shape: .automatic)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                }

                GroupBox("cornerRadius override") {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(height: 56)
                        .skeletonNode(cornerRadius: 24, kind: .generic)
                        .padding(.top, 8)
                }
            }
            .padding()
            .smartSkeleton(state.isLoading, config: state.currentConfig())
        }
        .navigationTitle("Kinds & Shapes")
        .toolbar {
            NavigationLink("Controls") { ControlPanelView() }
        }
    }
}
