//
//  SkeletonCoordinateSpace.swift
//  SmartShimmerSwiftUI
//
//  Created by Sharnabh on 19/03/26.
//

import Foundation
import SwiftUI

struct SkeletonCoordinateSpace: ViewModifier {
    let name = "SkeletonSpace"
    
    func body(content: Content) -> some View {
        content.coordinateSpace(name: name)
    }
}
