//
//  ShimmerPhase.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import SwiftUI

struct ShimmerPhase {
    static func value(date: Date, speed: Double) -> CGFloat {
        let time = date.timeIntervalSinceReferenceDate
        return CGFloat((time / speed).truncatingRemainder(dividingBy: 1))
    }
}
