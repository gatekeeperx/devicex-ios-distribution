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
            checksum: "f6711a3e5e48601e5967b210c98c908b97f8f7cc4e71f1c26920a9f46e610933"
        )
    ]
)
