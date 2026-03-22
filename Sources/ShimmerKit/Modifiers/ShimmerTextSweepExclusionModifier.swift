import SwiftUI

struct ShimmerTextSweepExclusionPreferenceKey: PreferenceKey {
    static let defaultValue: [Anchor<CGRect>] = []

    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> [Anchor<CGRect>]) {
        value.append(contentsOf: nextValue())
    }
}

struct ShimmerTextSweepExclusionModifier: ViewModifier {
    let isExcluded: Bool

    func body(content: Content) -> some View {
        if isExcluded {
            content.anchorPreference(
                key: ShimmerTextSweepExclusionPreferenceKey.self,
                value: .bounds
            ) { anchor in
                [anchor]
            }
        } else {
            content
        }
    }
}
