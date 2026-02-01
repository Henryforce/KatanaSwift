# KatanaSwift Examples

This directory contains example projects demonstrating how to use the `KatanaSwift` library.

## KatanaGoExample (SwiftUI)

This is a modern SwiftUI application that demonstrates:
- Scanning for Katana GO devices.
- Connecting and maintaining connection state.
- Switching between presets.
- Toggling the tuner.

### How to run

1.  Open the `Examples/KatanaGoExample` directory.
2.  Open `Package.swift` in Xcode.
3.  Ensure you are running on a **physical device** (iOS or macOS). *Bluetooth is not supported in the iOS Simulator.*
4.  If prompted, grant Bluetooth permissions to the app.

### Linking to the local library

The example project is configured to use the `KatanaSwift` package from the parent directory:

```swift
dependencies: [
    .package(name: "KatanaSwift", path: "../../")
]
```

This allows you to make changes to the library and see them reflected in the example app immediately.
