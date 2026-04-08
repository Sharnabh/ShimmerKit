//
//  StableSkeletonIDModifier.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct StableSkeletonIDModifier: ViewModifier {
    let id: AnyHashable

    func body(content: Content) -> some View {
        content.id(id)
    }
}
