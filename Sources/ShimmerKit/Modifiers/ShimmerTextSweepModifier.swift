import SwiftUI

struct ShimmerTextSweepModifier: ViewModifier {
    let config: ShimmerConfig
    let baseColor: Color

    func body(content: Content) -> some View {
        content
            .foregroundStyle(baseColor)
            .overlayPreferenceValue(ShimmerTextSweepExclusionPreferenceKey.self) { anchors in
                GeometryReader { proxy in
                    let excludedFrames = anchors.map { proxy[$0] }

                    ShimmerRenderer(config: config)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .mask(content)
                        .overlay {
                            if !excludedFrames.isEmpty {
                                content
                                    .mask {
                                        ZStack(alignment: .topLeading) {
                                            ForEach(Array(excludedFrames.enumerated()), id: \.offset) { _, frame in
                                                Rectangle()
                                                    .fill(Color.white)
                                                    .frame(width: frame.width, height: frame.height)
                                                    .position(x: frame.midX, y: frame.midY)
                                            }
                                        }
                                    }
                            }
                        }
                }
            }
    }
}
