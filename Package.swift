// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "KatanaSwift",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "KatanaSwift",
      targets: ["KatanaSwift"]
    ),
    .library(
      name: "KatanaGo",
      targets: ["KatanaGo"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/orchetect/MIDIKit", from: "0.11.0"),
    .package(url: "https://github.com/apple/swift-syntax", from: "600.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(name: "KatanaCore"),
    .macro(
      name: "KatanaMacrosImpl",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        "KatanaCore",
      ]
    ),
    .target(
      name: "KatanaMacros",
      dependencies: [
        "KatanaMacrosImpl",
        "KatanaCore",
      ]
    ),
    .target(name: "KatanaEQ", dependencies: ["KatanaCore", "KatanaMacros"]),
    .target(name: "KatanaFx", dependencies: ["KatanaCore", "KatanaMacros", "KatanaEQ"]),
    .target(
      name: "KatanaGoData",
      dependencies: [
        "KatanaMacros",
        "KatanaCore",
        "KatanaFx",
        "KatanaEQ",
      ]
    ),
    .target(
      name: "KatanaGo",
      dependencies: [
        "KatanaCore",
        "KatanaGoData",
      ]
    ),
    .target(
      name: "KatanaDeviceImpl",
      dependencies: [
        "KatanaCore",
        .product(name: "MIDIKit", package: "MIDIKit"),
      ]
    ),
    .target(
      name: "KatanaSwift",
      dependencies: [
        "KatanaDeviceImpl", "KatanaCore",
      ]
    ),
    .testTarget(
      name: "KatanaDeviceImplTests",
      dependencies: [
        "KatanaGo", "KatanaGoData", "KatanaDeviceImpl", "KatanaCore", "KatanaFx", "KatanaEQ",
      ]
    ),
    .testTarget(
      name: "KatanaGoDataTests",
      dependencies: ["KatanaGoData", "KatanaCore", "KatanaFx", "KatanaEQ"]
    ),
    .testTarget(
      name: "KatanaMacrosTests",
      dependencies: [
        "KatanaMacrosImpl",
        "KatanaCore",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
      ]
    ),
  ]
)
