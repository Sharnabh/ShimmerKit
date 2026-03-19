//
//  SkeletonKind.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

public enum SkeletonKind: Hashable, Sendable {
    
    case text(lineHeight: CGFloat)
    case image
    case generic
    
    // MARK: - Helpers
    
    var isText: Bool {
        if case .text = self { return true }
        return false
    }
    
    var isImage: Bool {
        if case .image = self { return true }
        return false
    }
    
    var isGeneric: Bool {
        if case .generic = self { return true }
        return false
    }
}
