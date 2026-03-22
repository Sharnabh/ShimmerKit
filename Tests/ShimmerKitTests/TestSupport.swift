import SwiftUI
@testable import ShimmerKit

func makeNode(
    frame: CGRect,
    cornerRadius: CGFloat = 8,
    kind: SkeletonKind = .generic,
    shapeStyle: SkeletonShapeStyle = .automatic,
    scope: String? = nil
) -> SkeletonNode {
    SkeletonNode(
        frame: frame,
        cornerRadius: cornerRadius,
        kind: kind,
        shapeStyle: shapeStyle,
        scope: scope
    )
}
