// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Validator",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        .watchOS(.v7),
        .tvOS(.v13),
    ],
    products: [
        .library(name: "ValidatorCore", targets: ["ValidatorCore"]),
        .library(name: "ValidatorUI", targets: ["ValidatorUI"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "ValidatorCore", dependencies: []),
        .target(name: "ValidatorUI", dependencies: ["ValidatorCore"]),
        .testTarget(name: "ValidatorTests", dependencies: ["ValidatorCore"]),
    ]
)
