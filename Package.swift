// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
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
    .package(url: "https://github.com/orchetect/MIDIKit", from: "0.10.7"),
    .package(url: "https://github.com/apple/swift-syntax", from: "602.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(name: "KatanaBank"),
    .macro(
      name: "KatanaMacrosImpl",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        "KatanaBank",
      ]
    ),
    .target(
      name: "KatanaMacros",
      dependencies: ["KatanaMacrosImpl"]
    ),
    .target(
      name: "KatanaGoData",
      dependencies: [
        "KatanaMacros",
        "KatanaBank",
      ]
    ),
    .target(
      name: "KatanaGoAPI",
      dependencies: [
        "KatanaGoData",
        "KatanaBank",
      ]
    ),
    .target(
      name: "KatanaGoMIDIKit",
      dependencies: [
        "KatanaGoAPI",
        "KatanaGoData",
        "KatanaBank",
        .product(name: "MIDIKit", package: "MIDIKit"),
      ]
    ),
    .target(
      name: "KatanaGoSwift",
      dependencies: ["KatanaGoAPI", "KatanaGoData", "KatanaGoMIDIKit", "KatanaBank"]
    ),
    .testTarget(
      name: "KatanaGoMIDIKitTests",
      dependencies: ["KatanaGoMIDIKit", "KatanaGoAPI", "KatanaGoData", "KatanaBank"]
    ),
  ]
)
