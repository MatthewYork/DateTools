import PackageDescription

let package = Package(
    name: "DateTools",
    targets: [
        Target(name: "DateTools")
    ]
)
package.exclude = ["Examples", "Tests"]
