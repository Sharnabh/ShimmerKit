//
//  SmartSkeletonModifier.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SmartSkeletonModifier: ViewModifier {
    
    var cornerRadius: CGFloat?
    var kind: SkeletonKind?
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                let frame = geo.frame(in: .named("SkeletonSpace"))
                
                let resolvedKind = kind ?? SkeletonHeuristics.inferKind(from: frame)
                let radius = cornerRadius ?? SkeletonHeuristics.defaultCornerRadius(for: resolvedKind)
                
                Color.clear.preference(
                    key: SkeletonNodePreferenceKey.self,
                    value: [
                        SkeletonNode(
                            frame: frame,
                            cornerRadius: radius,
                            kind: resolvedKind
                        )
                    ]
                )
            }
        )
    }
}
