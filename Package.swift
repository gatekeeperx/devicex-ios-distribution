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
            url: "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.5/Devicex.xcframework.zip",
            checksum: "804227c8373220e0a33e46437d0de26be13759703072e7f3a5ee94b035b69f8e"
        )
    ]
)
