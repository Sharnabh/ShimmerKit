//
//  ShimmerConfig.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import Foundation
import SwiftUI

public struct ShimmerConfig: @unchecked Sendable {
    public var gradient: Gradient
    public var textGradient: Gradient?
    public var skeletonColor: Color
    public var speed: Double
    public var angle: Angle
    public var splitMultilineText: Bool
    public var enableSemanticGrouping: Bool
    public var useLayoutProtocolIntegration: Bool
    
    public init(
        gradient: Gradient = Gradient(colors: [
            .clear,
            Color.white.opacity(0.35),
            .clear
        ]),
        textGradient: Gradient? = nil,
        skeletonColor: Color = Color.gray.opacity(0.25),
        speed: Double = 1.2,
        angle: Angle = .degrees(20),
        splitMultilineText: Bool = false,
        enableSemanticGrouping: Bool = false,
        useLayoutProtocolIntegration: Bool = false
    ) {
        self.gradient = gradient
        self.textGradient = textGradient
        self.skeletonColor = skeletonColor
        self.speed = speed
        self.angle = angle
        self.splitMultilineText = splitMultilineText
        self.enableSemanticGrouping = enableSemanticGrouping
        self.useLayoutProtocolIntegration = useLayoutProtocolIntegration
    }
    
    public init(
        shimmerColor: Color,
        textGradient: Gradient? = nil,
        skeletonColor: Color = Color.gray.opacity(0.25),
        shimmerOpacity: Double = 0.35,
        speed: Double = 1.2,
        angle: Angle = .degrees(20),
        splitMultilineText: Bool = false,
        enableSemanticGrouping: Bool = false,
        useLayoutProtocolIntegration: Bool = false
    ) {
        self.gradient = Gradient(colors: [
            .clear,
            shimmerColor.opacity(shimmerOpacity),
            .clear
        ])
        self.textGradient = textGradient
        self.skeletonColor = skeletonColor
        self.speed = speed
        self.angle = angle
        self.splitMultilineText = splitMultilineText
        self.enableSemanticGrouping = enableSemanticGrouping
        self.useLayoutProtocolIntegration = useLayoutProtocolIntegration
    }
}
