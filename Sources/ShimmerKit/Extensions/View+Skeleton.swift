//
//  View+Skeleton.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

public extension View {

    func smartSkeleton(
        _ isLoading: Bool,
        config: ShimmerConfig = ShimmerConfig(),
        includeScopes: [String]? = nil
    ) -> some View {
        Group {
            if isLoading {
                SmartSkeletonContainer(
                    config: config,
                    includeScopes: includeScopes
                ) {
                    self
                }
            } else {
                self
            }
        }
    }

    func shimmerText(
        config: ShimmerConfig = ShimmerConfig(),
        baseColor: Color = .primary
    ) -> some View {
        self.modifier(ShimmerTextModifier(config: config, baseColor: baseColor))
    }

    func shimmerTextSweep(
        config: ShimmerConfig = ShimmerConfig(),
        baseColor: Color = .primary
    ) -> some View {
        self.modifier(ShimmerTextSweepModifier(config: config, baseColor: baseColor))
    }

    func shimmerTextSweepExclude(_ isExcluded: Bool = true) -> some View {
        self.modifier(ShimmerTextSweepExclusionModifier(isExcluded: isExcluded))
    }

    func skeletonNode(
        cornerRadius: CGFloat? = nil,
        kind: SkeletonKind? = nil,
        shape: SkeletonShapeStyle = .automatic,
        scope: String? = nil
    ) -> some View {
        self.modifier(
            SmartSkeletonModifier(
                cornerRadius: cornerRadius,
                kind: kind,
                shapeStyle: shape,
                scope: scope
            )
        )
    }

    func skeletonID(_ id: AnyHashable) -> some View {
        self.modifier(StableSkeletonIDModifier(id: id))
    }
}
