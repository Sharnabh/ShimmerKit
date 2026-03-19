//
//  SmartSkeletonContainer.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SmartSkeletonContainer<Content: View>: View {
    
    let content: Content
    let config: ShimmerConfig
    
    @State private var nodes: [SkeletonNode] = []
    
    init(
        config: ShimmerConfig = ShimmerConfig(),
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.config = config
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            content.hidden()
            
            ForEach(processedNodes) { node in
                SkeletonShapeBuilder.shape(for: node)
                    .fill(Color.gray.opacity(0.25))
                    .frame(width: node.frame.width, height: node.frame.height)
                    .position(x: node.frame.midX, y: node.frame.midY)
                    .overlay(
                        ShimmerRenderer(config: config)
                            .mask(
                                SkeletonShapeBuilder.shape(for: node)
                            )
                    )
            }
        }
        .coordinateSpace(name: "SkeletonSpace")
        .onPreferenceChange(SkeletonNodePreferenceKey.self) {
            nodes = $0
        }
    }
    
    private var processedNodes: [SkeletonNode] {
        let merged = SkeletonProcessor.process(nodes)
        return SkeletonGrouping.groupTextLines(merged)
    }
}
