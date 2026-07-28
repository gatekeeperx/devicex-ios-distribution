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
            targets: ["DeviceX"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "DeviceX",
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.14/Devicex.xcframework.zip",
            checksum: "4f5a6e8c252b66a8540b5082e3031997449a68eb48b89a6d2e738ade9e5cfb5b"
        )
    ]
)
