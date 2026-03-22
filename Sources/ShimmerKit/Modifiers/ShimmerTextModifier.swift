import SwiftUI

struct ShimmerTextModifier: ViewModifier {
    let config: ShimmerConfig
    let baseColor: Color

    func body(content: Content) -> some View {
        content
            .foregroundStyle(baseColor)
            .overlay {
                GeometryReader { proxy in
                    ShimmerRenderer(config: config)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .mask(content)
                }
            }
    }
}
