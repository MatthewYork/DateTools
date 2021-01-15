// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "DateTools",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "DateToolsSwift",
            targets: ["DateToolsSwift"]),
        .library(
            name: "DateToolsObjC",
            targets: ["DateToolsObjC"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DateToolsSwift",
            dependencies: [],
            path: "DateToolsSwift/DateTools",
            exclude: [
                "DateTools",
                "Examples",
                "DateToolsSwift/Tests",
                "DateToolsSwift/Examples",
            ]
        ),
        .testTarget(
            name: "DateToolsSwiftTests",
            dependencies: ["DateToolsSwift"],
            path: "DateToolsSwift/Tests/DateToolsTests/DateToolsTestsTests",
            exclude: []
        ),
        .target(
            name: "DateToolsObjC",
            dependencies: [],
            path: "DateTools/DateTools",
            exclude: [
                "DateToolsSwift",
                "Examples",
                "DateTools/Tests",
                "DateTools/Examples",
            ]
        ),
        .testTarget(
            name: "DateToolsObjCTests",
            dependencies: ["DateToolsObjC"],
            path: "DateTools/Tests/DateToolsTests/DateToolsTestsTests",
            exclude: []
        ),

    ]
)
