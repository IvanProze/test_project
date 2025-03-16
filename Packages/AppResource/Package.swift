// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppResource",
    defaultLocalization: "en",
    platforms: [
          .iOS(.v16)
      ],
    products: [
        .library(
            name: "AppResource",
            targets: ["AppResource"]),
    ],
    targets: [
        
        .target(
            name: "AppResource",
            dependencies: [],
            resources: [
                .process("Fonts"),
                .process("Media.xcassets"),
                .process("Animation"),
            ]
)
])
