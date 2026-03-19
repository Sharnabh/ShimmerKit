//
//  SkeletonGrouping.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SkeletonGrouping {
    
    static func groupTextLines(_ nodes: [SkeletonNode]) -> [SkeletonNode] {
        nodes.map { node in
            var updated = node
            
            if case .text(let height) = node.kind {
                updated.cornerRadius = height / 2
            }
            
            return updated
        }
    }
}
