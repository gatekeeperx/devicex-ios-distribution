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
            checksum: "b0895f8c9062d6ac55557ea475da92aad63af8c3cf2ca773c98a290b07ab62af"
        )
    ]
)
