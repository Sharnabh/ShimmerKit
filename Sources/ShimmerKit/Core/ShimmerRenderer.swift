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

    private var angleVector: CGVector {
        let radians = config.angle.radians
        return CGVector(dx: cos(radians), dy: sin(radians))
    }

    private var gradientPoints: (start: UnitPoint, end: UnitPoint) {
        let vector = angleVector
        let half: CGFloat = 0.5

        return (
            start: UnitPoint(
                x: 0.5 - (vector.dx * half),
                y: 0.5 - (vector.dy * half)
            ),
            end: UnitPoint(
                x: 0.5 + (vector.dx * half),
                y: 0.5 + (vector.dy * half)
            )
        )
    }

    private func animatedGradientPoints(phase: CGFloat) -> (start: UnitPoint, end: UnitPoint) {
        let vector = angleVector
        let base = gradientPoints
        let travel: CGFloat = (phase * 2 - 1) * 0.8

        return (
            start: UnitPoint(
                x: base.start.x + (vector.dx * travel),
                y: base.start.y + (vector.dy * travel)
            ),
            end: UnitPoint(
                x: base.end.x + (vector.dx * travel),
                y: base.end.y + (vector.dy * travel)
            )
        )
    }

    var body: some View {
        TimelineView(.animation) { timeline in
            let phase = ShimmerPhase.value(date: timeline.date, speed: config.speed)
            let points = animatedGradientPoints(phase: phase)

            LinearGradient(
                gradient: config.gradient,
                startPoint: points.start,
                endPoint: points.end
            )
        }
    }
}
