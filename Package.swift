// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "DateToolsSwift",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DateToolsSwift",
            targets: ["DateToolsSwift"]
        ),
        .library(
            name: "DateToolsObjc",
            targets: ["DateToolsObjc"]
        )
    ],
    dependencies: [
        // Add external dependencies here if needed in the future
    ],
    targets: [
        .target(
            name: "DateToolsSwift",
            path: "DateToolsSwift/DateTools",
            resources: [.process("DateTools.bundle")],
            swiftSettings: [.define("SPM")]
        ),
        .target(
            name: "DateToolsObjc",
            path: "DateTools/DateTools",
            publicHeadersPath: ".",
            resources: [.process("DateTools.bundle")],
            cSettings: [.define("SPM")]
        )
    ]
)
