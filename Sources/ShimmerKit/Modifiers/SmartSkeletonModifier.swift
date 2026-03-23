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
    var shapeStyle: SkeletonShapeStyle = .automatic
    var scope: String?

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                let frame = geo.frame(in: .global)

                let resolvedKind = kind ?? SkeletonHeuristics.inferKind(from: frame)
                let radius = cornerRadius ?? SkeletonHeuristics.defaultCornerRadius(for: resolvedKind)
                let resolvedShapeStyle = SkeletonHeuristics.resolveShapeStyle(
                    preferred: shapeStyle,
                    kind: resolvedKind,
                    cornerRadius: radius
                )

                Color.clear.preference(
                    key: SkeletonNodePreferenceKey.self,
                    value: [
                        SkeletonNode(
                            frame: frame,
                            cornerRadius: radius,
                            kind: resolvedKind,
                            shapeStyle: resolvedShapeStyle,
                            scope: scope
                        )
                    ]
                )
            }
        )
    }
}
