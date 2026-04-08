//
//  SmartSkeletonContainer.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SmartSkeletonContainer<Content: View>: View {
    private struct RenderSkeletonNode: Identifiable {
        let id: String
        let node: SkeletonNode
    }

    let content: Content
    let config: ShimmerConfig
    let includeScopes: Set<String>?

    @State private var nodes: [SkeletonNode] = []

    init(
        config: ShimmerConfig = ShimmerConfig(),
        includeScopes: [String]? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.config = config
        self.includeScopes = includeScopes.map(Set.init)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            contentLayer
        }
        .overlay(alignment: .topLeading) {
            GeometryReader { proxy in
                let containerFrame = proxy.frame(in: .global)
                let containerSize = proxy.size

                ZStack(alignment: .topLeading) {
                    ForEach(renderNodes) { renderNode in
                        let node = renderNode.node
                        let localFrame = node.frame.offsetBy(
                            dx: -containerFrame.minX,
                            dy: -containerFrame.minY
                        )

                        SkeletonShapeBuilder.shape(for: node)
                            .fill(config.skeletonColor)
                            .frame(width: localFrame.width, height: localFrame.height)
                            .position(x: localFrame.midX, y: localFrame.midY)
                    }
                }
                .overlay(alignment: .topLeading) {
                    ShimmerRenderer(config: config)
                        .frame(width: containerSize.width, height: containerSize.height)
                        .mask(
                            ZStack(alignment: .topLeading) {
                                ForEach(renderNodes) { renderNode in
                                    let node = renderNode.node
                                    let localFrame = node.frame.offsetBy(
                                        dx: -containerFrame.minX,
                                        dy: -containerFrame.minY
                                    )

                                    SkeletonShapeBuilder.shape(for: node)
                                        .fill(Color.white)
                                        .frame(width: localFrame.width, height: localFrame.height)
                                        .position(x: localFrame.midX, y: localFrame.midY)
                                }
                            }
                        )
                }
            }
        }
        .onPreferenceChange(SkeletonNodePreferenceKey.self) { newNodes in
            let normalized = normalizeNodes(newNodes)
            if nodes != normalized {
                nodes = normalized
            }
        }
    }

    @ViewBuilder
    private var contentLayer: some View {
        if config.useLayoutProtocolIntegration {
            SkeletonPassthroughLayout {
                content.hiddenForSkeleton(true)
            }
        } else {
            content.hiddenForSkeleton(true)
        }
    }

    private var processedNodes: [SkeletonNode] {
        let nodesToRender: [SkeletonNode]

        if let includeScopes {
            nodesToRender = nodes.filter { node in
                guard let scope = node.scope else { return false }
                return includeScopes.contains(scope)
            }
        } else {
            nodesToRender = nodes
        }

        let merged = SkeletonProcessor.process(nodesToRender)
        return SkeletonGrouping.groupTextLines(
            merged,
            splitMultilineText: config.splitMultilineText,
            enableSemanticGrouping: config.enableSemanticGrouping
        )
    }

    private var renderNodes: [RenderSkeletonNode] {
        var occurrencesByID: [String: Int] = [:]

        return processedNodes.map { node in
            let occurrence = occurrencesByID[node.id, default: 0]
            occurrencesByID[node.id] = occurrence + 1
            let renderID = occurrence == 0 ? node.id : "\(node.id)#\(occurrence)"
            return RenderSkeletonNode(id: renderID, node: node)
        }
    }

    // private func normalizeNodes(_ input: [SkeletonNode]) -> [SkeletonNode] {
    //     input.sorted { lhs, rhs in
    //         if lhs.id != rhs.id {
    //             return lhs.id < rhs.id
    //         }
    //         if lhs.frame.minY != rhs.frame.minY {
    //             return lhs.frame.minY < rhs.frame.minY
    //         }
    //         if lhs.frame.minX != rhs.frame.minX {
    //             return lhs.frame.minX < rhs.frame.minX
    //         }
    //         if lhs.frame.width != rhs.frame.width {
    //             return lhs.frame.width < rhs.frame.width
    //         }
    //         return lhs.frame.height < rhs.frame.height
    //     }
    // }

    private func normalizeNodes(_ input: [SkeletonNode]) -> [SkeletonNode] {
        input.sorted { lhs, rhs in
            // Fix 2: Sort spatially FIRST so grouping algorithms don't break
            if lhs.frame.minY != rhs.frame.minY {
                return lhs.frame.minY < rhs.frame.minY
            }
            if lhs.frame.minX != rhs.frame.minX {
                return lhs.frame.minX < rhs.frame.minX
            }
            if lhs.frame.width != rhs.frame.width {
                return lhs.frame.width < rhs.frame.width
            }
            if lhs.frame.height != rhs.frame.height {
                return lhs.frame.height < rhs.frame.height
            }
            // Use ID as the final fallback for deterministic sorting
            return lhs.id < rhs.id
        }
    }
}
