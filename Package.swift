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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.3/Devicex.xcframework.zip",
            checksum: "0f41dd091765d281dfc22a85c670872cb8fd884158528b758ca9bdae397370c0"
        )
    ]
)
