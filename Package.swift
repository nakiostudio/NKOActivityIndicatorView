// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "NKOActivityIndicatorView",
    defaultLocalization: "en",
	platforms: [
        .iOS(.v8),
        .tvOS(.v9)
    ],
    products: [
        .library(name: "NKOActivityIndicatorView",
            targets: ["NKOActivityIndicatorView"])
    ],
	targets: [
        .target(
           name: "NKOActivityIndicatorView",
           path: "NKOActivityIndicatorView/Classes",
           publicHeadersPath: "."
        )
    ]
)