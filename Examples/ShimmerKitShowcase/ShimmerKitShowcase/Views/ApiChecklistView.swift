import SwiftUI

struct ApiChecklistView: View {
    private let rows: [String] = [
        "View.smartSkeleton(_:config:includeScopes:)",
        "View.skeletonNode(cornerRadius:kind:shape:scope:)",
        "View.skeletonID(_:)",
        "ShimmerKit.defaultConfig",
        "ShimmerKit.config(_ profile:)",
        "ShimmerKit.config(gradient:...)",
        "ShimmerKit.config(shimmerColor:...)",
        "ShimmerConfig.init(gradient:...)",
        "ShimmerConfig.init(shimmerColor:...)",
        "ShimmerProfile enum",
        "SkeletonKind enum",
        "SkeletonShapeStyle enum",
        "SkeletonNode model"
    ]

    var body: some View {
        List(rows, id: \.self) { row in
            Label(row, systemImage: "checkmark.circle.fill")
                .foregroundStyle(.green)
        }
        .navigationTitle("API Checklist")
    }
}
