//
//  SkeletonNode.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import Foundation
import SwiftUI

public struct SkeletonNode: Identifiable, Hashable, Sendable {
    public var id: String {
        Self.stableID(
            frame: frame,
            cornerRadius: cornerRadius,
            kind: kind,
            shapeStyle: shapeStyle,
            scope: scope
        )
    }
    
    public var frame: CGRect
    public var cornerRadius: CGFloat
    public var kind: SkeletonKind
    public var shapeStyle: SkeletonShapeStyle
    public var scope: String?
    
    private static func stableID(
        frame: CGRect,
        cornerRadius: CGFloat,
        kind: SkeletonKind,
        shapeStyle: SkeletonShapeStyle,
        scope: String?
    ) -> String {
        let frameToken = [
            quantized(frame.minX),
            quantized(frame.minY),
            quantized(frame.width),
            quantized(frame.height)
        ].map(String.init).joined(separator: ":")
        
        let kindToken: String
        switch kind {
        case .text(let lineHeight):
            kindToken = "text:\(quantized(lineHeight))"
        case .image:
            kindToken = "image"
        case .generic:
            kindToken = "generic"
        }
        
        let shapeToken: String
        switch shapeStyle {
        case .automatic:
            shapeToken = "auto"
        case .roundedRectangle(let cornerRadius):
            shapeToken = "rounded:\(quantized(cornerRadius))"
        case .capsule:
            shapeToken = "capsule"
        case .circle:
            shapeToken = "circle"
        }
        
        let scopeToken = scope ?? "_"
        return "\(frameToken)|\(kindToken)|\(shapeToken)|r:\(quantized(cornerRadius))|s:\(scopeToken)"
    }
    
    private static func quantized(_ value: CGFloat) -> Int {
        Int((value * 100).rounded())
    }
}
