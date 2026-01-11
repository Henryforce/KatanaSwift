import BLECombineKit
import BLECombineKitMocks
import Combine
import CoreBluetooth
import XCTest

@testable import KatanaGoAPI
@testable import KatanaGoBLE

final class KatanaGoScannerBLETests: XCTestCase {
  var scanner: KatanaGoScannerBLE!
  var mockCentral: MockBLECentralManager!

  override func setUp() {
    super.setUp()
    mockCentral = MockBLECentralManager()
    scanner = KatanaGoScannerBLE(central: mockCentral)
  }

  func testScanFiltersByServiceUUID() async {
    // Given
    let expectedServiceUUID = CBUUID(string: "03B80E5A-EDE8-4B33-A751-6CE34EC4C700")

    // When
    let stream = scanner.scan()

    // Wait until the stream has a first value to ensure the scan is started correctly
    for await _ in stream { break }

    // Then
    XCTAssertEqual(mockCentral.scanForPeripheralsWasCalledCount, 1)
    XCTAssertEqual(mockCentral.scanForPeripheralsServices, [expectedServiceUUID])
  }
}
