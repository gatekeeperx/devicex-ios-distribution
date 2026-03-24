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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.6/Devicex.xcframework.zip",
            checksum: "15e2d3506bc484ddc4b0885f3d77c50eca6728f48b0f0116bc65fdd25a4ddd7e"
        )
    ]
)
