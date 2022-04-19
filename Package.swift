// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "spmlocal",
    products: [
        .library(
            name: "Logger",
            type: .static,
            targets: ["LoggerTarget"]),
        .library(
            name: "HelloWorld",
            type: .static,
            targets: ["HelloWorldTarget"]),
    ],
    dependencies: [
        .package(
            name: "CocoaLumberjack",
            url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git",
            from: "3.7.0"),
        .package(
            name: "TTGSnackbar",
            url: "https://github.com/zekunyan/TTGSnackbar.git",
            from: "1.10.5"),
    ],
    targets: [
        .target(
              name: "LoggerTarget",
              dependencies: [.target(name: "LoggerWrapper",
                                     condition: .when(platforms: [.iOS]))]
            ),
        .target(
              name: "LoggerWrapper",
              dependencies: [
                .target(name: "Logger", condition: .when(platforms: [.iOS])),
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack", condition: .when(platforms: [.iOS]))
              ]
            ),
        .binaryTarget(name: "Logger", url: "https://sanjtestbucketspm.s3.ap-southeast-1.amazonaws.com/Logger.xcframework.zip", checksum: "f2aa44236d062ae9e55e09aba4d8eb79cba002d284c6b4ef7fa698171f3da777"),
        .target(
              name: "HelloWorldTarget",
              dependencies: [.target(name: "HelloWorldWrapper",
                                     condition: .when(platforms: [.iOS]))]
            ),
        .target(
              name: "HelloWorldWrapper",
              dependencies: [
                .target(name: "HelloWorld", condition: .when(platforms: [.iOS])),
                .product(name: "TTGSnackbar", package: "TTGSnackbar", condition: .when(platforms: [.iOS])),
                "Logger"
              ]
            ),
        .binaryTarget(name: "HelloWorld", url: "https://sanjtestbucketspm.s3.ap-southeast-1.amazonaws.com/HelloWorld.xcframework.zip", checksum: "e618831c1152e3e18d39e6fd0db850410cbf30f7a37ba0132cb4e4133563ff4d")
    ]
)
