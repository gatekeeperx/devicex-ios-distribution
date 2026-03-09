// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Devicex",
    platforms: [
        .iOS(.v13)
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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.4/Devicex.xcframework.zip",
            checksum: "d6727188197efebc10bb967d2cf9d94bafc60705944cebf3f911e891981412d4"
        )
    ]
)
