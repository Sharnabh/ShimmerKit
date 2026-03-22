//
//  DemoRedactedComparisonView.swift
//  ShimmerKitShowcase
//
//  Created by Sharnabh on 22/03/26.
//

import SwiftUI
import ShimmerKit

struct DemoRedactedComparisonView: View {
    @EnvironmentObject private var state: ShowcaseState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Same content, same loading state. Left: Apple redaction. Right: ShimmerKit.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Apple .redacted")
                        .font(.headline)

                    comparisonCard
                        .redacted(reason: state.isLoading ? .placeholder : [])
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 16) {
                    Text("ShimmerKit")
                        .font(.headline)

                    shimmerCard
                        .smartSkeleton(state.isLoading, config: state.currentConfig())
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 8) {
                    Text("What ShimmerKit adds")
                        .font(.headline)
                    Text("• Directional animated gradient")
                    Text("• Shape-aware placeholders (circle/capsule/rounded)")
                    Text("• Scoped and partial rendering")
                    Text("• Advanced grouping options")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle("Redacted Comparison")
        .toolbar {
            NavigationLink("Controls") { ControlPanelView() }
        }
    }

    private var comparisonCard: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(.gray.opacity(0.2))
                .frame(width: 52, height: 52)

            VStack(alignment: .leading, spacing: 6) {
                Text("Sofia Carter")
                    .font(.headline)
                Text("Senior iOS Engineer")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Shipped 4 features this week")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    private var shimmerCard: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(.gray.opacity(0.2))
                .frame(width: 52, height: 52)
                .skeletonNode(kind: .image, shape: .circle)

            VStack(alignment: .leading, spacing: 6) {
                Text("Sofia Carter")
                    .font(.headline)
                    .skeletonNode(kind: .text(lineHeight: 18), shape: .capsule)

                Text("Senior iOS Engineer")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .skeletonNode(kind: .text(lineHeight: 14), shape: .capsule)

                Text("Shipped 4 features this week")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .skeletonNode(kind: .text(lineHeight: 12), shape: .capsule)
            }

            Spacer()
        }
    }
}
