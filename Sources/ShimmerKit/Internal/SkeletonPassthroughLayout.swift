//
//  SkeletonPassthroughLayout.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SkeletonPassthroughLayout: Layout {
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        guard let first = subviews.first else { return .zero }
        return first.sizeThatFits(proposal)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard let first = subviews.first else { return }
        first.place(at: bounds.origin, proposal: proposal)
    }
}
