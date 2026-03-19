// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ShimmerKit",
    platforms: [
        .macOS(.v15),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ShimmerKit",
            targets: ["ShimmerKit"]
        )
    ],
    targets: [
        .target(
            name: "ShimmerKit",
            dependencies: []
        )
    ]
)
