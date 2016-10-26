import PackageDescription

let package = Package(
    name: "DateTools",
    targets: [
        Target(name: "DateTools")
    ],
    exclude: ["Examples", "Tests"]
)
