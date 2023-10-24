// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MapView991",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "MapView991", targets: ["MapView991"])
    ],
    targets: [
        .target(name: "MapView991"),
        .testTarget(name: "MapView991Tests", dependencies: ["MapView991"])
    ]
)
