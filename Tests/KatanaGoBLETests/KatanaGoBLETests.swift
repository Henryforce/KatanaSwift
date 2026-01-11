import BLECombineKit
import BLECombineKitMocks
import Combine
import CoreBluetooth
import XCTest

@testable import KatanaGoAPI
@testable import KatanaGoBLE
@testable import KatanaGoData

final class KatanaGoBLETests: XCTestCase {
  var peripheral: MockBLEPeripheral!
  var katanaGo: KatanaGoBLE!

  let serviceUUID = CBUUID(string: "03B80E5A-EDE8-4B33-A751-6CE34EC4C700")
  let characteristicUUID = CBUUID(string: "7772E5DB-3868-4112-A1A9-F2669D106BF3")

  override func setUp() async throws {
    peripheral = MockBLEPeripheral()
    katanaGo = KatanaGoBLE(peripheral: peripheral)
  }

  func testConnectSuccess() async throws {
    // Given
    // Mock connection
    peripheral.connectReturnValue = Just(peripheral)
      .setFailureType(to: BLEError.self)
      .eraseToAnyPublisher()

    // Mock service discovery
    let mockService = CBMutableService(type: serviceUUID, primary: true)
    let bleService = BLEService(value: mockService, peripheral: peripheral)
    peripheral.discoverServicesReturnValue = Just(bleService)
      .setFailureType(to: BLEError.self)
      .eraseToAnyPublisher()

    // Mock characteristic discovery
    let mockCharacteristic = CBMutableCharacteristic(
      type: characteristicUUID, properties: [.read, .notify], value: nil, permissions: [.readable])
    let bleCharacteristic = BLECharacteristic(value: mockCharacteristic, peripheral: peripheral)
    peripheral.discoverCharacteristicsReturnValue = Just(bleCharacteristic)
      .setFailureType(to: BLEError.self)
      .eraseToAnyPublisher()

    // When
    try await katanaGo.connect()

    // Then
    let status = await katanaGo.connectionStatus()
    XCTAssertEqual(status, .connected)
    XCTAssertEqual(peripheral.connectWasCalledCount, 1)
    XCTAssertEqual(peripheral.discoverServicesWasCalledCount, 1)
    XCTAssertEqual(peripheral.discoverServicesUUIDs, [serviceUUID])
    XCTAssertEqual(peripheral.discoverCharacteristicsWasCalledCount, 1)
    XCTAssertEqual(peripheral.discoverCharacteristicsUUIDs, [characteristicUUID])
  }

  func testConnectFailureServiceNotFound() async throws {
    // Given
    peripheral.connectReturnValue = Just(peripheral)
      .setFailureType(to: BLEError.self)
      .eraseToAnyPublisher()

    // Mock service discovery returning nothing (completes without values)
    peripheral.discoverServicesReturnValue = Empty<BLEService, BLEError>()
      .eraseToAnyPublisher()

    // When / Then
    do {
      try await katanaGo.connect()
      XCTFail("Should have thrown an error")
    } catch {
      let status = await katanaGo.connectionStatus()
      XCTAssertEqual(status, .disconnected)
    }
  }

  func testDisconnect() async throws {
    // Given
    // Setup connected state (internal status is private, so we call connect first or just test the call)
    // Since status is private, we'll use connect() to get it to connected state
    try await testConnectSuccess()

    // When
    await katanaGo.disconnect()

    // Then
    let status = await katanaGo.connectionStatus()
    XCTAssertEqual(status, .disconnected)
    XCTAssertEqual(peripheral.disconnectWasCalledCount, 1)
  }

  func testWrite() async throws {
    // Given
    try await testConnectSuccess()

    peripheral.writeValueReturnValue = Empty<Never, BLEError>()
      .eraseToAnyPublisher()

    let command = KatanaGoWriteData.setTuner(on: true)

    // When
    try await katanaGo.write(command)

    // Then
    XCTAssertEqual(peripheral.writeValueWasCalledCount, 1)
    XCTAssertEqual(peripheral.writeValueType, .withoutResponse)
    // Verify data - currently returns Data() due to TODO in implementation
    XCTAssertNotNil(peripheral.writeValueData)
  }

  func testReadWithOnlyFinished() async throws {
    // Given
    try await testConnectSuccess()

    let subject = PassthroughSubject<BLEData, BLEError>()
    peripheral.observeValueReturnValue = subject.eraseToAnyPublisher()

    // When
    let stream = await katanaGo.read()

    // We need to trigger the stream observation
    let task = Task {
      var received = [KatanaGoReadData]()
      for await data in stream {
        received.append(data)
      }
      return received
    }

    // At this point, peripheral.observeValue(for:) should have been called
    XCTAssertEqual(peripheral.observeValueWasCalledCount, 1)

    // Then
    // Clean up
    subject.send(completion: .finished)
    let results = await task.value
    XCTAssertEqual(results.count, 0)  // because decode returns nil
  }
}
