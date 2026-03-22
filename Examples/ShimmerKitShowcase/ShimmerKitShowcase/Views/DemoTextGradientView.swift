import SwiftUI
import ShimmerKit

struct DemoTextGradientView: View {
    private let helloConfig = ShimmerConfig(
        gradient: Gradient(colors: [
            .clear,
            .pink.opacity(0.9),
            .orange.opacity(0.9),
            .clear
        ]),
        speed: 1.0,
        angle: .degrees(20)
    )

    private let titleConfig = ShimmerConfig(
        gradient: Gradient(colors: [
            .clear,
            .cyan.opacity(0.9),
            .mint.opacity(0.9),
            .clear
        ]),
        speed: 1.2,
        angle: .degrees(28)
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Animated gradient passing through text (no skeleton).")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Hello")
                        .font(.system(size: 64, weight: .heavy, design: .rounded))
                        .shimmerText(config: helloConfig, baseColor: .gray.opacity(0.35))

                    Text("Gradient through text")
                        .font(.title2.weight(.bold))
                        .shimmerText(config: titleConfig, baseColor: .gray.opacity(0.3))

                    Text("Use .shimmerText(...) directly on Text for this effect.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 12) {
                    Text("Single sweep across multiple text blocks")
                        .font(.headline)

                    HStack(alignment: .top, spacing: 14) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Headline")
                                .font(.title3.weight(.bold))
                            Text("Two lines")
                                .font(.subheadline)
                            Text("Left stack")
                                .font(.caption.weight(.semibold))
                        }
                        .shimmerTextSweepExclude()

                        Spacer(minLength: 0)

                        VStack(alignment: .trailing, spacing: 8) {
                            Text("Status")
                                .font(.subheadline.weight(.semibold))
                            Text("ACTIVE")
                                .font(.title3.weight(.black))
                            Text("98%")
                                .font(.caption)
                                .shimmerTextSweepExclude()
                        }
                    }

                    Text("Apply .shimmerTextSweep(...) to parent containers for one aligned animation over mixed text layouts. Use .shimmerTextSweepExclude() on specific text or stacks to opt out.")
                        .font(.footnote)
                }
                .shimmerTextSweep(config: titleConfig, baseColor: .gray.opacity(0.32))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Single sweep across multiple text blocks")
                        .font(.headline)
                        .shimmerTextSweepExclude()

                    HStack(alignment: .top, spacing: 14) {
                        HStack {
                            Text("H")
                                .font(.system(size: 64, weight: .heavy, design: .rounded))
                            VStack(alignment: .leading){
                                Text("eello")
                                Text("Check this out !")
                            }
                        }
                    }

                    Text("Apply .shimmerTextSweep(...) to parent containers for one aligned animation over mixed text layouts.")
                        .font(.footnote)
                        .shimmerTextSweepExclude()
                }
                .shimmerTextSweep(config: titleConfig, baseColor: .gray.opacity(0.32))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle("Text Gradient")
    }
}
