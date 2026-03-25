// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Devicex",
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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.7/Devicex.xcframework.zip",
            checksum: "aa41f19f7e0a8938ffa6effc2ae3e31b6b4a406688194b8a0527763d881c47fc"
        )
    ]
)
