//
//  WholeViewShimmerLoadingModifier.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 08/04/26.
//

import SwiftUI

struct WholeViewShimmerLoadingModifier<Placeholder: View, Background: View>: ViewModifier {
    let isLoading: Bool
    let config: ShimmerConfig
    let background: Background
    let placeholder: Placeholder

    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0 : 1)
            .allowsHitTesting(!isLoading)
            .overlay(alignment: .topLeading) {
                if isLoading {
                    ZStack(alignment: .topLeading) {
                        background
                        placeholder
                            .overlay {
                                GeometryReader { proxy in
                                    ShimmerRenderer(config: config)
                                        .frame(width: proxy.size.width, height: proxy.size.height)
                                        .mask(placeholder)
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
    }
}
