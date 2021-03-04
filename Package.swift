// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "DateToolsSwift",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "DateToolsSwift", targets: ["DateToolsSwift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "DateToolsSwift",
                path: "DateToolsSwift/DateTools",
                exclude: ["Tests", "Examples", "doc_gen.sh", "DateTools.bundle"]),
//        .testTarget(
//            name: "DateToolsTests",
//            dependencies: ["DateToolsSwift"],
//            path: "DateToolsSwift/Tests/DateToolsTests/DateToolsTestsTests",
//            exclude: ["DataTools", "Examples", "DateToolsTests", "doc_gen.sh", "Info.plist"]),
    ]
)
    