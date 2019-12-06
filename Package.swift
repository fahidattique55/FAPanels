// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "FAPanels",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "FAPanels",
            targets: ["FAPanels"]),
    ],
    dependencies: [
        // no dependencies
    ],
    targets: [
        .target(name: "FAPanels", path: "FAPanels/Classes")
    ]
)
    
