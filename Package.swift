// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "VisionUI",
    platforms: [
        .visionOS(.v2),
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(name: "VisionUI", targets: ["VisionUI"])
    ],
    targets: [
        .target(
            name: "VisionUI",
            path: "Sources/VisionUI"
        ),
        .testTarget(
            name: "VisionUITests",
            dependencies: ["VisionUI"]
        )
    ]
)
