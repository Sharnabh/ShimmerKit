//
//  WholeViewShimmerLoadingModifier.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 08/04/26.
//

import SwiftUI

struct WholeViewShimmerLoadingModifier<Placeholder: View>: ViewModifier {
    let isLoading: Bool
    let config: ShimmerConfig
    let placeholder: Placeholder

    func body(content: Content) -> some View {
        Group {
            if isLoading {
                placeholder
                    .overlay {
                        GeometryReader { proxy in
                            ShimmerRenderer(config: config)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .mask(placeholder)
                        }
                    }
            } else {
                content
            }
        }
    }
}