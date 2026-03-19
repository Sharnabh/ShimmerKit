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
    public var speed: Double
    public var angle: Angle
    
    public init(
        gradient: Gradient = Gradient(colors: [
            .clear,
            Color.white.opacity(0.35),
            .clear
        ]),
        speed: Double = 1.2,
        angle: Angle = .degrees(20)
    ) {
        self.gradient = gradient
        self.speed = speed
        self.angle = angle
    }
}
