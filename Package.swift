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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.9/Devicex.xcframework.zip",
            checksum: "59c5ee6db4bd468d84468361f220f31fdecfd4e4c5ac0055e37aca209a705e7e"
        )
    ]
)
