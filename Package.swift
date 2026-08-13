// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PAYJP",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "PAYJP", targets: ["PAYJP"])
    ],
    dependencies: [
        .package(url: "https://github.com/PhoneNumberKit/PhoneNumberKit.git", from: "5.0.6")
    ],
    targets: [
        .target(
            name: "PAYJP-ObjC",
            dependencies: [],
            path: "Sources/ObjC",
            publicHeadersPath: "Public"
        ),
        .target(
            name: "PAYJP",
            dependencies: [
                "PAYJP-ObjC",
                .product(name: "PhoneNumberKit", package: "PhoneNumberKit")
            ],
            path: "Sources",
            exclude: [
                "ObjC",
                "Info.plist"
            ],
            resources: [
                .process("Resources/Views"),
                .process("Resources/Resource.bundle"),
                .process("Resources/Assets.xcassets")
            ]
        )
    ]
)
