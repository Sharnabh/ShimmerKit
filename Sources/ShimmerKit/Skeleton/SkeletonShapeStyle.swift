//
//  SkeletonShapeStyle.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import Foundation
import SwiftUI

public enum SkeletonShapeStyle: Hashable, Sendable {
    case automatic
    case roundedRectangle(cornerRadius: CGFloat)
    case capsule
    case circle
}
