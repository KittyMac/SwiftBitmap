// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftBitmap",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "SwiftBitmap", targets: ["SwiftBitmap"])
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "CZLIB"
        ),
        .target(
            name: "CPNG",
            dependencies: [ "CZLIB" ]
        ),
        .target(
            name: "bitmap",
            dependencies: [ "CPNG" ]
        ),
        .target(
            name: "SwiftBitmap",
            dependencies: [ "bitmap" ]
        ),
        .testTarget(
            name: "SwiftBitmapTests",
            dependencies: [ "SwiftBitmap" ],
            exclude: [ "Resources" ]
        )

    ]
)
