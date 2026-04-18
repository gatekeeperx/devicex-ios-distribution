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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.11/Devicex.xcframework.zip",
            checksum: "66a1084c680615349eead572982be8cba722c5e8d4bf8a07538b3631aff02e0a"
        )
    ]
)
