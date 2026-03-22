//
//  ShimmerKitShowcaseApp.swift
//  ShimmerKitShowcase
//
//  Created by Sharnabh on 22/03/26.
//

import SwiftUI
import ShimmerKit


@main
struct ShimmerKitShowcaseApp: App {
    @StateObject private var state = ShowcaseState()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ShowcaseHomeView()
            }
            .environmentObject(state)
        }
    }
}
