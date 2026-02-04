import Foundation
import KatanaGoData

enum DataBankParseStatus {
  case invalidMessageLength
  case invalidMessageCommand
  case start
  case processed
  case end
}

/// A parser for Katana Go MIDI messages.
enum KatanaGoMIDIParser {
  /// Parses a raw MIDI SysEx message and updates the DataBank with extracted data.
  ///
  /// The expected message format follows the Roland DT1 protocol observed in Katana Go sessions:
  /// [Header (5 bytes), Address (4 bytes), Data (N bytes), Checksum (1 byte)]
  ///
  /// - Parameters:
  ///   - message: The raw bytes received from the MIDI device.
  ///   - dataBank: The bank to be updated with the parsed data.
  static func parse(_ message: [UInt8], into dataBank: inout KatanaGoRawDataBank)
    -> [KatanaGoDataBank]
  {
    // Minimum valid message length: Header(5) + Address(4) + Checksum(1) = 10 bytes
    guard message.count >= 10 else {
      return []
    }

    // Validate the DT1 command byte (0x12, which is 18)
    // Most Katana Go messages start with a preamble like [16, 1, 5, 13, 18]
    guard message[4] == 18 else {
      return []
    }

    // Extract Address (4 bytes starting at index 5)
    let address = Array(message[5...8])

    // Extract Data (Payload between address and checksum)
    let data = Array(message[9..<(message.count - 1)])

    // Update the DataBank with the extracted data at the specified address
    return dataBank.update(using: data, startingAt: address)
  }
}
