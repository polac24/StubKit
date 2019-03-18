// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "StubKit",
    products: [
        .library(name: "StubKit", targets: ["StubKit"]),
    ],
    targets: [
        .target(
            name: "StubKit",
            path: "StubKit/Classes"
        ),
        .testTarget(
            name: "StubKitTests",
            dependencies: ["StubKit"],
            path: "Example/StubKitExampleTests"
        ),
    ]
)
