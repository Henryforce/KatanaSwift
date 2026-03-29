# KatanaSwift

A Swift library for interacting with the [BOSS Katana GO](https://www.boss.info/global/products/katana-go/) guitar headphone amp over MIDI / SysEx

**_NOTE:_** Future support for other Katana models might be added in the future.

This library provides a clean, async/await interface to scan for, connect to, and control your Katana GO device.

## Features

- 🔍 **Device Scanning**: Easily discover connected Katana GO devices.
- ⚡ **Async/Await API**: Modern Swift Concurrency support for all operations.
- 🎸 **Command Support**: Write CC and SysEx commands to toggle effects, change presets, and switch the tuner.
- 📥 **Real-time Updates**: Stream data back from the device using `AsyncStream`.

## Installation

Add this package to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/Henryforce/KatanaSwift.git", from: "0.1.0")
```

Or add it via Xcode: **File > Add Packages...** and use the repository URL.

## Quick Start

### 1. Connect to Katana Go

Either connect manually from your phone's bluetooth settings or use:

- [CABTMIDIViewController](https://developer.apple.com/documentation/coreaudiokit/cabtmidicentralviewcontroller) in iOS
- [CABTLCentralViewController](https://developer.apple.com/documentation/coreaudiokit/cabtlemidiwindowcontroller) in macOS

### 2. Scan for Katana Go Devices

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

### 3. Control the Device

```swift
// Write raw bytes to the device.
try await device.write(at: 0x1F000000, data: [0x01])
```

```swift
import KatanaGo

// Write data banks
try await device.writeBank(AmpBank(type: .clean))
```

### 4. Read Data

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

This project is not affiliated with or endorsed by BOSS or Roland Corporation. "BOSS" and "Katana" are trademarks of Roland Corporation.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

A lot of the definitions and addresses were reverse engineered from sniffing the raw SysEx data and some of the tricky definitions were referenced from the [Fx Floorboard](https://sourceforge.net/projects/fxfloorboard/) project based on the work of the following people:
- [gumtownbassman](https://sourceforge.net/u/gumtownbassman/profile/)
- [ucomesdag](https://sourceforge.net/u/ucomesdag/profile/)