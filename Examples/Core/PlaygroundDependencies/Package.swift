// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlaygroundDependencies",
    products: [
        .library(name: "PlaygroundDependencies", targets: ["PlaygroundDependencies"]),
    ],
    targets: [
        .target(name: "PlaygroundDependencies"),
        .testTarget(name: "PlaygroundDependenciesTests", dependencies: ["PlaygroundDependencies"]),
    ]
)

package.dependencies = [
    .package(path: "../../../"),
]
package.targets = [
    .target(
        name: "PlaygroundDependencies",
        dependencies: [
            .product(name: "ValidatorCore", package: "validator"),
        ]
    ),
]
package.platforms = [
    .iOS("16.0"),
    .macOS("13.0"),
    .tvOS("16.0"),
    .watchOS("9.0"),
]
