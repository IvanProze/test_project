// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppData",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AppData",
            targets: ["AppData"]
        )
    ],
    dependencies: [
        .package(path: "../AppResource"),
        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", from: "6.0.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0")

    ],
    targets: [
        .target(
            name: "AppData",
            dependencies: [
                .product(name: "AppResource", package: "AppResource"),
                .product(name: "SwifterSwift", package: "SwifterSwift"),
                .product(name: "SDWebImage", package: "SDWebImage"),
            ]
        )
    ]
)
