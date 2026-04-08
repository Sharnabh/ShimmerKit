//
//  SkeletonShapeBuilder.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct AnyShape: Shape, Sendable {

    private let pathBuilder: @Sendable (CGRect) -> Path

    init<S: Shape & Sendable>(_ shape: S) {
        self.pathBuilder = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        pathBuilder(rect)
    }
}

struct SkeletonShapeBuilder {

    static func shape(for node: SkeletonNode) -> AnyShape {
        switch node.shapeStyle {
        case .automatic:
            return AnyShape(RoundedRectangle(cornerRadius: node.cornerRadius))
        case .roundedRectangle(let cornerRadius):
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        case .capsule:
            return AnyShape(Capsule())
        case .circle:
            return AnyShape(Circle())
        }
    }
}
