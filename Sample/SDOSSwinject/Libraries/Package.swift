// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Libraries",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Libraries",
            targets: ["Libraries"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.7.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Libraries",
            dependencies: [
                "Swinject"
            ]),
    ]
)
