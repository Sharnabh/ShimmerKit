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
    
    @ViewBuilder
    static func shape(for node: SkeletonNode) -> AnyShape {
        switch node.kind {
        case .text(let height):
            return AnyShape(RoundedRectangle(cornerRadius: height / 2))
            
        case .image:
            return AnyShape(RoundedRectangle(cornerRadius: node.cornerRadius))
            
        case .generic:
            return AnyShape(RoundedRectangle(cornerRadius: node.cornerRadius))
        }
    }
}
