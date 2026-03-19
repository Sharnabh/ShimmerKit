//
//  SkeletonTargetModifier.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SkeletonTargetModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.modifier(SmartSkeletonModifier())
    }
}
