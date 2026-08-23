// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PAYJP",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "PAYJP", targets: ["PAYJP"])
    ],
    dependencies: [
        .package(url: "https://github.com/PhoneNumberKit/PhoneNumberKit.git", from: "5.0.6"),
        .package(url: "https://github.com/PhoneNumberKit/PhoneNumberKitUI.git", from: "1.1.0")
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
                .product(name: "PhoneNumberKit", package: "PhoneNumberKit"),
                .product(name: "PhoneNumberKitUI", package: "PhoneNumberKitUI")
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
