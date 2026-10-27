// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
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
        ),
        .library(
            name: "DateToolsObjc",
            targets: ["DateToolsObjc"]
        )
    ],
    dependencies: [],
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
