//
//  ShimmerRenderer.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import Foundation
import SwiftUI

struct ShimmerRenderer: View {
    let config: ShimmerConfig
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            let phase = CGFloat((t / config.speed).truncatingRemainder(dividingBy: 1))
            
            LinearGradient(
                gradient: config.gradient,
                startPoint: .leading,
                endPoint: .trailing
            )
            .offset(x: phase * 300 - 150)
        }
    }
}
