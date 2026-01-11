import BLECombineKit
@preconcurrency import Combine
@preconcurrency import CoreBluetooth
import Foundation
import KatanaGoAPI
import KatanaGoData

public final class KatanaGoScannerBLE: KatanaGoScanner, @unchecked Sendable {
  private let central: BLECentralManager
  private let serviceUUID = CBUUID(string: "03B80E5A-EDE8-4B33-A751-6CE34EC4C700")

  public init(central: BLECentralManager? = nil) {
    self.central = central ?? BLECombineKit.buildCentralManager()
  }

  public func scan() -> AsyncStream<KatanaGo> {
    let stream = central.state
      .filter { $0 == .poweredOn }
      .first()
      .flatMap { [central, serviceUUID] _ in
        central.scanForPeripherals(withServices: [serviceUUID], options: nil)
      }
      .map { KatanaGoBLE(peripheral: $0.peripheral) }

    return AsyncStream { continuation in
      let cancellable = stream.sink(
        receiveCompletion: { _ in continuation.finish() },
        receiveValue: { continuation.yield($0) }
      )

      let box = CancellableBox(cancellable)
      continuation.onTermination = { _ in
        box.cancel()
      }
    }
  }
}

private final class CancellableBox: @unchecked Sendable {
  private var cancellable: AnyCancellable?
  private let lock = NSLock()

  init(_ cancellable: AnyCancellable) {
    self.cancellable = cancellable
  }

  func cancel() {
    lock.lock()
    defer { lock.unlock() }
    cancellable?.cancel()
    cancellable = nil
  }
}
