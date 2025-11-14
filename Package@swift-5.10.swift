// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Validator",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "ValidatorCore", targets: ["ValidatorCore"]),
        .library(name: "ValidatorUI", targets: ["ValidatorUI"]),
    ],
    targets: [
        .target(name: "ValidatorCore", dependencies: []),
        .target(name: "ValidatorUI", dependencies: ["ValidatorCore"]),
        .testTarget(name: "ValidatorCoreTests", dependencies: ["ValidatorCore"]),
        .testTarget(name: "ValidatorUITests", dependencies: ["ValidatorCore", "ValidatorUI"]),
    ]
)
