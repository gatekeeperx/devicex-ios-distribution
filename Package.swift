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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.15/Devicex.xcframework.zip",
            checksum: "f1e2b0ce751b179cdc4e4beb4dcda9fe2b9b2c310f06e85d8daf00be6555d13b"
        )
    ]
)
