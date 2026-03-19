// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public enum ShimmerKit {
    
    /// Default shimmer configuration
    public static let defaultConfig = ShimmerConfig()
    
    /// Create a custom shimmer configuration
    public static func config(
        gradient: Gradient = Gradient(colors: [
            .clear,
            Color.white.opacity(0.35),
            .clear
        ]),
        speed: Double = 1.2,
        angle: Angle = .degrees(20)
    ) -> ShimmerConfig {
        ShimmerConfig(
            gradient: gradient,
            speed: speed,
            angle: angle
        )
    }
}
