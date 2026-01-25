@propertyWrapper
public struct Parameter<T: Sendable & Hashable>: Sendable, Hashable {
  package var value: T
  public let address: UInt32
  package var updated = false

  public var wrappedValue: T {
    get { return value }
    set {
      value = newValue
      updated = true
    }
  }

  public var projectedValue: Parameter<T> {
    get { return self }
    set { self = newValue }
  }

  public init(wrappedValue: T, at address: UInt32) {
    self.value = wrappedValue
    self.address = address
  }
}

@propertyWrapper
public struct FxParameter<T: Sendable & Hashable>: Sendable, Hashable {
  package var value: T
  public let id: FxID
  package var updated = false

  public var wrappedValue: T {
    get { return value }
    set {
      value = newValue
      updated = true
    }
  }

  public var projectedValue: FxParameter<T> {
    get { return self }
    set { self = newValue }
  }

  public init(wrappedValue: T, id: FxID) {
    self.value = wrappedValue
    self.id = id
  }
}

@propertyWrapper
public struct IntegerParameter<T: BinaryInteger & Sendable & Hashable>:
  Sendable, Hashable
{
  package var value: T
  public let address: UInt32
  public let range: ClosedRange<T>
  package var updated = false

  public var wrappedValue: T {
    get { return value }
    set {
      value = max(range.lowerBound, min(newValue, range.upperBound))
      updated = true
    }
  }

  public var projectedValue: IntegerParameter<T> {
    get { return self }
    set { self = newValue }
  }

  public init(wrappedValue: T, at address: UInt32, range: ClosedRange<T>) {
    self.value = max(range.lowerBound, min(wrappedValue, range.upperBound))
    self.address = address
    self.range = range
  }
}

@propertyWrapper
public struct IntegerFxParameter<T: BinaryInteger & Sendable & Hashable>:
  Sendable, Hashable
{
  package var value: T
  public let id: FxID
  public let range: ClosedRange<T>
  package var updated = false

  public var wrappedValue: T {
    get { return value }
    set {
      value = max(range.lowerBound, min(newValue, range.upperBound))
      updated = true
    }
  }

  public var projectedValue: IntegerFxParameter<T> {
    get { return self }
    set { self = newValue }
  }

  public init(wrappedValue: T, id: FxID, range: ClosedRange<T>) {
    self.value = max(range.lowerBound, min(wrappedValue, range.upperBound))
    self.id = id
    self.range = range
  }
}