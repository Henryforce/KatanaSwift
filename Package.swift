// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "KatanaGoSwift",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "KatanaGoSwift",
      targets: ["KatanaGoSwift"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/Henryforce/BLECombineKit.git", branch: "master")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "KatanaGoData"
    ),
    .target(
      name: "KatanaGoAPI",
      dependencies: ["KatanaGoData"]
    ),
    .target(
      name: "KatanaGoBLE",
      dependencies: [
        "KatanaGoAPI",
        "KatanaGoData",
        .product(name: "BLECombineKit", package: "BLECombineKit"),
      ]
    ),
    .target(
      name: "KatanaGoSwift",
      dependencies: ["KatanaGoAPI", "KatanaGoData", "KatanaGoBLE"]
    ),
    .testTarget(
      name: "KatanaGoBLETests",
      dependencies: [
        "KatanaGoBLE",
        .product(name: "BLECombineKitMocks", package: "BLECombineKit"),
      ]
    ),
  ]
)
