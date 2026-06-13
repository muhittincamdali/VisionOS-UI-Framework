// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VisionOS-UI-Framework",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "VisionUI", targets: ["VisionUI"]),
    ],
    targets: [
        .target(
            name: "VisionUI",
            path: "Sources/VisionUI",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "VisionUITests",
            dependencies: ["VisionUI"]
        )
    ]
)
