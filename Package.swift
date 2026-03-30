// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "devicex-ios-distribution",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Devicex",
            targets: ["Devicex"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Devicex",
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.8/Devicex.xcframework.zip",
            checksum: "65e7624062a47b346e1b327eda541cf7e41737c6cc4c6ff03c5c5004eff5fd65"
        )
    ]
)
