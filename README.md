# KatanaSwift

A Swift library for interacting with the **BOSS Katana GO** guitar headphone amp over Bluetooth Low Energy (BLE).

This library provides a clean, async/await interface to scan for, connect to, and control your Katana GO device.

## Features

- 🔍 **Device Scanning**: Easily discover Katana GO devices.
- 🔗 **BLE Connectivity**: Reliable connection management using `BLECombineKit`.
- ⚡ **Async/Await API**: Modern Swift Concurrency support for all operations.
- 🎸 **Command Support**: Write CC and SysEx commands to toggle effects, change presets, and switch the tuner.
- 📥 **Real-time Updates**: Stream data back from the device using `AsyncStream`.

## Installation

Add this package to your `Package.swift`:

```swift
.package(url: "https://github.com/Henryforce/KatanaGoSwift.git", branch: "main")
```

Or add it via Xcode: **File > Add Packages...** and enter the repository URL.

## Quick Start

### 1. Scan for Devices

```swift
import KatanaSwift

let scanner = KatanaSwift.buildScanner()

for await device in scanner.scan() {
    print("Found Katana GO!")
    // Connect to the first one found
    try await device.connect()
    break
}
```

### 2. Control the Device

```swift
// Write raw bytes to the device.
try await device.write(at: 0x1F000000, data: [0x01])
```

```swift
import KatanaGo

// Write data banks
try await device.writeBank(AmpBank(type: .clean))
```

### 3. Read Data

```swift
// Read data from the device at a specific address.
let data = try await device.readData(at: 0x1F000000, length: 1, options: .deviceOnly)
```

## Running the Example Project

A sample SwiftUI application is included in the `Examples` directory to help you get started.

### Setup Instructions:

1.  Open your terminal and navigate to the project root.
2.  Open the library in Xcode: `open Package.swift`.
3.  The example project needs to be linked to your local development version of the library.
4.  Follow the instructions in [Examples/README.md](Examples/README.md) to build and run the app.

## Permissions

Since this library uses Bluetooth, you **must** add the following key to your app's `Info.plist`:

*   `NSBluetoothAlwaysUsageDescription`: "This app needs Bluetooth to connect to and control your BOSS Katana GO."

## Disclaimer

This project is not affiliated with, authorized, or endorsed by BOSS or Roland Corporation. "BOSS" and "Katana" are trademarks of Roland Corporation.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.