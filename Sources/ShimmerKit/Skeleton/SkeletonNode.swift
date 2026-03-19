//
//  SkeletonNode.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import Foundation
import SwiftUI

public struct SkeletonNode: Identifiable, Hashable, Sendable {
    public let id = UUID()
    
    public var frame: CGRect
    public var cornerRadius: CGFloat
    public var kind: SkeletonKind
}
