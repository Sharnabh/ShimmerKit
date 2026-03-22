import SwiftUI
import ShimmerKit

struct DemoListIdentityView: View {
    @EnvironmentObject private var state: ShowcaseState

    var body: some View {
        List {
            ForEach(state.products) { product in
                HStack(spacing: 12) {
                    Circle()
                        .fill(.gray.opacity(0.2))
                        .frame(width: 44, height: 44)
                        .skeletonNode(kind: .image)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title)
                            .font(.headline)
                            .skeletonNode(kind: .text(lineHeight: 18))

                        Text(product.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .skeletonNode(kind: .text(lineHeight: 14))
                    }

                    Spacer()

                    Text(product.price)
                        .font(.subheadline.weight(.semibold))
                        .skeletonNode(kind: .text(lineHeight: 14))
                }
                .padding(.vertical, 6)
                .skeletonID(product.id)
            }
        }
        .listStyle(.plain)
        .smartSkeleton(state.isLoading, config: state.currentConfig())
        .navigationTitle("List Identity")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Reload") {
                    Task { await state.reloadData() }
                }
                NavigationLink("Controls") { ControlPanelView() }
            }
        }
    }
}
