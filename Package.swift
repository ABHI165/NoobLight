// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NoobLight",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NoobLight",
            targets: ["NoobLight"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NoobLight",
            dependencies: [])]
)
