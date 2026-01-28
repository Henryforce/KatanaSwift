//
//  DeleteMe.swift
//  KatanaGoExample
//
//  Created by Henry Javier Serrano Echeverria on 2026/01/28.
//

import KatanaMacros

enum HFx: Sendable, Hashable {
  case chorus(HChorus)
  case flanger(HFlanger)
}

enum HChorus: Sendable, Hashable {
  case rate
  case level
}

enum HFlanger: Sendable, Hashable {
  case speed
  case level
}

@propertyWrapper
struct HFxParameter<T: Sendable & Hashable>: Sendable, Hashable {
  var value: T
  let id: HFx
  var updated = false

  var wrappedValue: T {
    get { return value }
    set {
      value = newValue
      updated = true
    }
  }

  var projectedValue: HFxParameter<T> {
    get { return self }
    set { self = newValue }
  }

  init(wrappedValue: T, id: HFx) {
    self.value = wrappedValue
    self.id = id
  }
}

protocol HenryBankProtocol {
  static var bankAddress: UInt32 { get }
  static var size: UInt32 { get }
}

@propertyWrapper
struct MainWrapper<T: Sendable & Hashable>: Sendable, Hashable {
  var value: T
  let index: UInt32
  var updated = false

  var wrappedValue: T {
    get { return value }
    set {
      value = newValue
      updated = true
    }
  }

  var projectedValue: MainWrapper<T> {
    get { return self }
    set { self = newValue }
  }

  init(wrappedValue: T, index: UInt32) {
    self.value = wrappedValue
    self.index = index
  }
}

enum HEnum: UInt8, Sendable, Hashable {
  case henrys = 0
  case ayitas
}

@KatanaUInt8RawBytes
extension HEnum {}

struct HenryBank: HenryBankProtocol {
  @MainWrapper(index: 0)
  var type: HEnum = .henrys

  static let bankAddress: UInt32 = 0x20_01_00_00

  static let size: UInt32 = 1
}

enum HenryFunctions {
  static func doSomething() {
    //    HenryBankProtocol.Type
  }
}
