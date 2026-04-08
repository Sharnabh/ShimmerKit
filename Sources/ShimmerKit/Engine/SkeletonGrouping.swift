//
//  SkeletonGrouping.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct SkeletonGrouping {

    static func groupTextLines(
        _ nodes: [SkeletonNode],
        splitMultilineText: Bool = false,
        enableSemanticGrouping: Bool = false
    ) -> [SkeletonNode] {
        let textProcessed = nodes.flatMap { node in
            switch node.kind {
            case .text(let lineHeight):
                if splitMultilineText {
                    return splitTextNode(node, lineHeight: lineHeight)
                }
                var updated = node
                updated.cornerRadius = lineHeight / 2
                return [updated]
            case .image, .generic:
                return [node]
            }
        }

        guard enableSemanticGrouping else {
            return textProcessed
        }

        return applySemanticGrouping(to: textProcessed)
    }

    private static func splitTextNode(_ node: SkeletonNode, lineHeight: CGFloat) -> [SkeletonNode] {
        let resolvedLineHeight = max(4, lineHeight)
        let nodeHeight = node.frame.height

        guard nodeHeight > resolvedLineHeight * 1.7 else {
            var single = node
            single.cornerRadius = resolvedLineHeight / 2
            return [single]
        }

        let estimatedSpacing = max(2, resolvedLineHeight * 0.35)
        let estimatedLines = Int(((nodeHeight + estimatedSpacing) / (resolvedLineHeight + estimatedSpacing)).rounded())
        let lineCount = max(2, estimatedLines)

        let availableSpacing = max(0, nodeHeight - (CGFloat(lineCount) * resolvedLineHeight))
        let spacing = lineCount > 1 ? availableSpacing / CGFloat(lineCount - 1) : 0
        let renderedHeight = (CGFloat(lineCount) * resolvedLineHeight) + (CGFloat(max(0, lineCount - 1)) * spacing)
        let topInset = max(0, (nodeHeight - renderedHeight) / 2)

        return (0..<lineCount).map { index in
            var lineNode = node
            let isLastLine = index == (lineCount - 1)
            let widthFactor: CGFloat = isLastLine && lineCount > 1 ? 0.72 : 1.0
            let width = node.frame.width * widthFactor
            let y = node.frame.minY + topInset + CGFloat(index) * (resolvedLineHeight + spacing)

            lineNode.frame = CGRect(
                x: node.frame.minX,
                y: y,
                width: width,
                height: resolvedLineHeight
            )
            lineNode.cornerRadius = resolvedLineHeight / 2
            return lineNode
        }
    }

    private static func applySemanticGrouping(to nodes: [SkeletonNode]) -> [SkeletonNode] {
        let textHeights = nodes.compactMap { node -> CGFloat? in
            guard case .text(let lineHeight) = node.kind else { return nil }
            return lineHeight
        }

        guard
            let minHeight = textHeights.min(),
            let maxHeight = textHeights.max(),
            textHeights.count >= 2,
            (maxHeight - minHeight) >= 2
        else {
            return nodes
        }

        let titleThreshold = minHeight + ((maxHeight - minHeight) * 0.55)

        return nodes.map { node in
            guard case .text(let lineHeight) = node.kind else {
                return node
            }

            var updated = node
            let isTitle = lineHeight >= titleThreshold

            if !isTitle {
                updated.frame = CGRect(
                    x: node.frame.minX,
                    y: node.frame.minY,
                    width: node.frame.width * 0.9,
                    height: node.frame.height
                )
            }

            return updated
        }
    }
}
