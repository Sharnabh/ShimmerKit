//
//  SkeletonPreferenceKey.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import Foundation
import SwiftUI

struct SkeletonNodePreferenceKey: PreferenceKey {

    static let defaultValue: [SkeletonNode] = []

    static func reduce(value: inout [SkeletonNode], nextValue: () -> [SkeletonNode]) {
        value.append(contentsOf: nextValue())
    }
}
