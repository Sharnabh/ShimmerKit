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
        config: ShimmerConfig = ShimmerConfig()
    ) -> some View {
        Group {
            if isLoading {
                SmartSkeletonContainer(config: config) {
                    self
                }
            } else {
                self
            }
        }
    }
    
    func skeletonNode(
        cornerRadius: CGFloat? = nil,
        kind: SkeletonKind? = nil
    ) -> some View {
        self.modifier(
            SmartSkeletonModifier(
                cornerRadius: cornerRadius,
                kind: kind
            )
        )
    }
    
    func skeletonID(_ id: AnyHashable) -> some View {
        self.modifier(StableSkeletonIDModifier(id: id))
    }
}
