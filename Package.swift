// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CXoneGuideUtility",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "CXoneGuideUtility",
            targets: ["CXoneGuideUtility"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Kolos65/Mockable", from: "0.0.11"),
    ],
    targets: [
        .target(
            name: "CXoneGuideUtility",
            dependencies: [
                .product(name: "Mockable", package: "Mockable")
            ],
            path: "Sources",
            swiftSettings: [
                .define("MOCKING", .when(configuration: .debug))
            ],
            plugins: []
        ),
        .testTarget(
            name: "CXoneGuideUtilityTests",
            dependencies: [
                "CXoneGuideUtility",
                .product(name: "Mockable", package: "Mockable")
            ],
            path: "Tests"
        )
    ]
)
