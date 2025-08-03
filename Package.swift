// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VisionOS-UI-Framework",
    platforms: [
        .visionOS(.v1_0)
    ],
    products: [
        .library(
            name: "VisionUI",
            targets: ["VisionUI"]
        ),
        .library(
            name: "VisionUISpatial",
            targets: ["VisionUISpatial"]
        ),
        .library(
            name: "VisionUIGestures",
            targets: ["VisionUIGestures"]
        ),
        .library(
            name: "VisionUIAccessibility",
            targets: ["VisionUIAccessibility"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "VisionUI",
            dependencies: [
                "VisionUISpatial",
                "VisionUIGestures",
                "VisionUIAccessibility"
            ],
            path: "Sources/VisionUI",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-enable-actor-data-race-checks"])
            ]
        ),
        .target(
            name: "VisionUISpatial",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections")
            ],
            path: "Sources/VisionUI/Spatial",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-enable-actor-data-race-checks"])
            ]
        ),
        .target(
            name: "VisionUIGestures",
            dependencies: [
                "VisionUISpatial"
            ],
            path: "Sources/VisionUI/Gestures",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-enable-actor-data-race-checks"])
            ]
        ),
        .target(
            name: "VisionUIAccessibility",
            dependencies: [
                "VisionUISpatial"
            ],
            path: "Sources/VisionUI/Accessibility",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-enable-actor-data-race-checks"])
            ]
        ),
        .testTarget(
            name: "VisionUITests",
            dependencies: [
                "VisionUI",
                "VisionUISpatial",
                "VisionUIGestures",
                "VisionUIAccessibility"
            ],
            path: "Tests"
        )
    ]
) 