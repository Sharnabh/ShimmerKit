import SwiftUI
import ShimmerKit
import Combine

@MainActor
final class ShowcaseState: ObservableObject {
    @Published var isLoading = true
    @Published var speed: Double = 1.0
    @Published var angle: Double = 30
    @Published var shimmerOpacity: Double = 0.45
    @Published var shimmerColor: Color = .mint
    @Published var skeletonColor: Color = .gray.opacity(0.2)

    @Published var splitMultilineText = true
    @Published var enableSemanticGrouping = true
    @Published var useLayoutProtocolIntegration = false

    @Published var selectedProfile: ProfileSelection = .custom

    @Published var includeHeaderScope = true
    @Published var includeBodyScope = true
    @Published var includeActionScope = false

    @Published var products: [DemoProduct] = [
        DemoProduct(id: UUID(), title: "Wireless Headphones", subtitle: "Noise Cancelling", price: "$199"),
        DemoProduct(id: UUID(), title: "Smart Watch", subtitle: "Fitness + Health", price: "$249"),
        DemoProduct(id: UUID(), title: "Laptop Stand", subtitle: "Aluminium", price: "$49")
    ]

    var includedScopes: [String]? {
        let scopes = [
            includeHeaderScope ? "header" : nil,
            includeBodyScope ? "body" : nil,
            includeActionScope ? "actions" : nil
        ].compactMap { $0 }

        return scopes.isEmpty ? [] : scopes
    }

    func currentConfig() -> ShimmerConfig {
        if let profile = selectedProfile.shimmerProfile {
            return ShimmerKit.config(profile)
        }

        return ShimmerKit.config(
            shimmerColor: shimmerColor,
            skeletonColor: skeletonColor,
            shimmerOpacity: shimmerOpacity,
            speed: speed,
            angle: .degrees(angle),
            splitMultilineText: splitMultilineText,
            enableSemanticGrouping: enableSemanticGrouping,
            useLayoutProtocolIntegration: useLayoutProtocolIntegration
        )
    }

    func reloadData() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 1_600_000_000)
        products = [
            DemoProduct(id: UUID(), title: "Mechanical Keyboard", subtitle: "Low Profile", price: "$129"),
            DemoProduct(id: UUID(), title: "4K Monitor", subtitle: "USB-C", price: "$399"),
            DemoProduct(id: UUID(), title: "Portable SSD", subtitle: "1TB NVMe", price: "$139")
        ]
        isLoading = false
    }
}
