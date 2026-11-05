// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CXoneGuideUtility",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CXoneGuideUtility",
            targets: ["CXoneGuideUtility"]
        )
    ],
    dependencies: [
        // Pinned exactly: Mockable 0.6.3+ caps xctest-dynamic-overlay below 1.10.0 (its manifest checks `swift(>=6.0)`
        // instead of `compiler(>=6.0)`), which clashes with swift-issue-reporting pulled in by swift-custom-dump.
        // Revisit once Mockable fixes the check upstream.
        .package(url: "https://github.com/Kolos65/Mockable", exact: "0.6.2"),
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
            ]
        )
    ]
)
