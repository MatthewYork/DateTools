// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "DateToolsSwift",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        .library(
            name: "DateToolsSwift",
            targets: ["DateToolsSwift"])
    ],
    targets: [
        .target(
            name: "DateToolsSwift",
            path: "DateToolsSwift/DateTools",
            exclude: [
                "Examples",
                "DateToolsSwift/Examples"
            ],
            resources: [
                .copy("DateTools.bundle")
            ]
        ),
        .testTarget(
            name: "DateToolsSwiftTests",
            dependencies: ["DateToolsSwift"],
            path: "DateToolsSwift/Tests/DateToolsTests/DateToolsTestsTests",
            exclude: [
                "Info.plist"
            ],
            resources: [
                .copy("DateTools.bundle")
            ]
        )
    ]
)
