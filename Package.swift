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
        .systemLibrary(
            name: "CPNG",
            path: "Library/CPNG",
            pkgConfig: "libpng",
            providers: [ .brew(["libpng"]), .apt(["libpng"])]
        ),
        .systemLibrary(
            name: "CJPEG",
            path: "Library/CJPEG",
            pkgConfig: "libjpeg",
            providers: [ .brew(["libjpeg"]), .apt(["libjpeg"])]
        ),
        .target(
            name: "bitmap",
            dependencies: [ "CPNG", "CJPEG" ]
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
