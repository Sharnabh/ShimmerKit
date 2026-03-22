// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public enum ShimmerKit {
    
    /// Default shimmer configuration
    public static let defaultConfig = ShimmerConfig()
    
    /// Create a configuration from a preset profile.
    public static func config(_ profile: ShimmerProfile) -> ShimmerConfig {
        switch profile {
        case .default:
            return ShimmerConfig()
        case .subtle:
            return ShimmerConfig(
                gradient: Gradient(colors: [
                    .clear,
                    Color.white.opacity(0.22),
                    .clear
                ]),
                skeletonColor: Color.gray.opacity(0.2),
                speed: 1.35,
                angle: .degrees(16),
                splitMultilineText: false,
                enableSemanticGrouping: false,
                useLayoutProtocolIntegration: false
            )
        case .feedLoading:
            return ShimmerConfig(
                gradient: Gradient(colors: [
                    .clear,
                    Color.white.opacity(0.4),
                    .clear
                ]),
                skeletonColor: Color.gray.opacity(0.24),
                speed: 1.0,
                angle: .degrees(30),
                splitMultilineText: true,
                enableSemanticGrouping: true,
                useLayoutProtocolIntegration: false
            )
        case .detailPage:
            return ShimmerConfig(
                gradient: Gradient(colors: [
                    .clear,
                    Color.white.opacity(0.45),
                    .clear
                ]),
                skeletonColor: Color.gray.opacity(0.22),
                speed: 0.9,
                angle: .degrees(38),
                splitMultilineText: true,
                enableSemanticGrouping: true,
                useLayoutProtocolIntegration: true
            )
        }
    }
    
    /// Create a custom shimmer configuration
    public static func config(
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
    ) -> ShimmerConfig {
        ShimmerConfig(
            gradient: gradient,
            textGradient: textGradient,
            skeletonColor: skeletonColor,
            speed: speed,
            angle: angle,
            splitMultilineText: splitMultilineText,
            enableSemanticGrouping: enableSemanticGrouping,
            useLayoutProtocolIntegration: useLayoutProtocolIntegration
        )
    }
    
    /// Create a shimmer configuration using a single shimmer highlight color.
    public static func config(
        shimmerColor: Color,
        textGradient: Gradient? = nil,
        skeletonColor: Color = Color.gray.opacity(0.25),
        shimmerOpacity: Double = 0.35,
        speed: Double = 1.2,
        angle: Angle = .degrees(20),
        splitMultilineText: Bool = false,
        enableSemanticGrouping: Bool = false,
        useLayoutProtocolIntegration: Bool = false
    ) -> ShimmerConfig {
        ShimmerConfig(
            shimmerColor: shimmerColor,
            textGradient: textGradient,
            skeletonColor: skeletonColor,
            shimmerOpacity: shimmerOpacity,
            speed: speed,
            angle: angle,
            splitMultilineText: splitMultilineText,
            enableSemanticGrouping: enableSemanticGrouping,
            useLayoutProtocolIntegration: useLayoutProtocolIntegration
        )
    }
}
