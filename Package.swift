// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DateToolsSwift",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DateToolsSwift",
            targets: ["DateToolsSwift"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DateToolsSwift",
            path: "DateToolsSwift/DateTools",
            resources: [.process("DateTools.bundle")],
            swiftSettings: [.define("SPM")]
        )
    ]
)