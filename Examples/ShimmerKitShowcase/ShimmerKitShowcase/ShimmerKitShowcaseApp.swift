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
    @StateObject private var loadingController = ShimmerLoadingController()

    private let globalLoadingConfig = ShimmerKit.config(.detailPage)

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ShowcaseHomeView()
            }
            .shimmerLoading(loadingController, config: globalLoadingConfig) {
                VStack(spacing: 14) {
                    Text("Preparing your content")
                        .font(.title3.bold())
                    Text("Waiting for the final request to complete")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(globalLoadingConfig.skeletonColor)
                        .frame(width: 280, height: 20)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(globalLoadingConfig.skeletonColor)
                        .frame(width: 240, height: 20)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(globalLoadingConfig.skeletonColor)
                        .frame(width: 300, height: 120)
                }
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
            }
            .environmentObject(state)
            .environmentObject(loadingController)
        }
    }
}
