import SwiftUI
import ShimmerKit

struct HomeLoadingPlaceholderView: View {
    let config: ShimmerConfig

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(config.skeletonColor)
                    .frame(height: 34)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<5, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 14)
                                .fill(config.skeletonColor)
                                .frame(width: 110, height: 40)
                        }
                    }
                    .padding(.horizontal, 16)
                }

                RoundedRectangle(cornerRadius: 12)
                    .fill(config.skeletonColor)
                    .frame(height: 48)
                    .padding(.horizontal, 16)

                RoundedRectangle(cornerRadius: 20)
                    .fill(config.skeletonColor)
                    .frame(height: 180)
                    .padding(.horizontal, 20)

                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(config.skeletonColor)
                        .frame(width: 110, height: 20)
                    Spacer()
                    RoundedRectangle(cornerRadius: 8)
                        .fill(config.skeletonColor)
                        .frame(width: 70, height: 16)
                }
                .padding(.horizontal, 16)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 12)], spacing: 12) {
                    ForEach(0..<8, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 14)
                            .fill(config.skeletonColor)
                            .frame(height: 140)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
        .background(Color.white)
    }
}
