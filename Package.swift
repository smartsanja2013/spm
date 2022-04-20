// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "spmlocal",
    products: [
        .library(
            name: "Logger",
            targets: ["LoggerTarget"]),
        .library(
            name: "HelloWorld",
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
        .binaryTarget(name: "Logger", url: "https://sanjtestbucketspm.s3.ap-southeast-1.amazonaws.com/Logger.xcframework.zip", checksum: "a6b688bc5f33368979f95ee2e14463703b80e4db1b73792cfac685fc5993d149"),
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
        .binaryTarget(name: "HelloWorld", url: "https://sanjtestbucketspm.s3.ap-southeast-1.amazonaws.com/HelloWorld.xcframework.zip", checksum: "043817e318c52dff083fb0a4fd251a0e96c3dac6fcec82d14e883d6b4da20d53")
    ]
)
