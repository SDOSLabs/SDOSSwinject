// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SDOSSwinject",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .executable(
            name: "SDOSSwinjectScript",
            targets: ["SDOSSwinjectScript"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "SDOSSwinjectScript",
                path: "src/Scripts/Classes")
    ]
)
