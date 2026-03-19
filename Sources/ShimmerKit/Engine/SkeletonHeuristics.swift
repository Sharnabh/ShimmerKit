//
//  SkeletonHeuristics.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SkeletonHeuristics {
    
    static func inferKind(from frame: CGRect) -> SkeletonKind {
        if frame.height < 20 {
            return .text(lineHeight: frame.height)
        } else if abs(frame.width - frame.height) < 2 {
            return .image
        } else {
            return .generic
        }
    }
    
    static func defaultCornerRadius(for kind: SkeletonKind) -> CGFloat {
        switch kind {
        case .text(let h):
            return h / 2
        case .image:
            return 12
        case .generic:
            return 8
        }
    }
}
