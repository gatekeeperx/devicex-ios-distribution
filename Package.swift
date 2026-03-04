// swift-tools-version:5.5
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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.2/Devicex.xcframework.zip",
            checksum: "b79c1de82345d7050751fe7db99ae5701a442a8b0314cd71d6814ab9ec853d6e"
        )
    ]
)
