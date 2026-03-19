//
//  SkeletonProcessor.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SkeletonProcessor {
    
    static func process(_ nodes: [SkeletonNode]) -> [SkeletonNode] {
        // 1. Remove noise
        let filtered = nodes.removingInvalidFrames()
        
        // 2. Merge overlaps
        var result: [SkeletonNode] = []
        
        for node in filtered {
            if let index = result.firstIndex(where: {
                $0.frame.intersects(node.frame)
            }) {
                var merged = result[index]
                merged.frame = merged.frame.union(node.frame)
                result[index] = merged
            } else {
                result.append(node)
            }
        }
        
        return result
    }
}
