//
//  Utilities.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

extension CGRect {
    
    var isValidSkeletonFrame: Bool {
        width > 4 && height > 4 && !isInfinite && !isNull
    }
    
    func intersectsSignificantly(with other: CGRect) -> Bool {
        let intersection = self.intersection(other)
        return intersection.width > 2 && intersection.height > 2
    }
    
    func merged(with other: CGRect) -> CGRect {
        self.union(other)
    }
}

extension Array where Element == SkeletonNode {
    
    func removingInvalidFrames() -> [SkeletonNode] {
        self.filter { $0.frame.isValidSkeletonFrame }
    }
}

extension CGFloat {
    
    func isAlmostEqual(to value: CGFloat, tolerance: CGFloat = 1.0) -> Bool {
        abs(self - value) < tolerance
    }
}

extension View {
    
    func hiddenForSkeleton(_ hidden: Bool) -> some View {
        self.opacity(hidden ? 0 : 1)
    }
}

#if DEBUG
extension View {
    
    func debugSkeletonFrame(_ color: Color = .red) -> some View {
        self.overlay(
            Rectangle()
                .stroke(color, lineWidth: 1)
        )
    }
}
#endif
