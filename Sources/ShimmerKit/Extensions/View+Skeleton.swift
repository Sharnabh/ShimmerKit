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

    func shimmerLoading<Placeholder: View>(
        _ isLoading: Bool,
        config: ShimmerConfig = ShimmerConfig(),
        @ViewBuilder placeholder: () -> Placeholder
    ) -> some View {
        self.modifier(
            WholeViewShimmerLoadingModifier(
                isLoading: isLoading,
                config: config,
                placeholder: placeholder()
            )
        )
    }

    func shimmerLoading<Placeholder: View>(
        _ controller: ShimmerLoadingController,
        config: ShimmerConfig = ShimmerConfig(),
        @ViewBuilder placeholder: () -> Placeholder
    ) -> some View {
        self.modifier(
            WholeViewShimmerLoadingModifier(
                isLoading: controller.isLoading,
                config: config,
                placeholder: placeholder()
            )
        )
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
