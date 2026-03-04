// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Devicex",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "DevicexSDK",
            targets: ["Devicex"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Devicex",
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.1/Devicex.xcframework.zip",
            checksum: "4778ee8afc873e1e1f7689eade5e73311c86bc92a2c5e5d82e228b04d13032a9"
        )
    ]
)
