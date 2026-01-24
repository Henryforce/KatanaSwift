@propertyWrapper
public struct Parameter<T: Sendable & Hashable>: Sendable, Hashable {
  package var value: T
  public let address: UInt64
  package var shouldUpdate = false

  public var wrappedValue: T {
    get { return value }
    set { value = newValue }
  }

  public var projectedValue: Parameter<T> {
    get { return self }
    set { self = newValue }
  }

  init(wrappedValue: T, at address: UInt64) {
    self.value = wrappedValue
    self.address = address
  }
}

@propertyWrapper
public struct IntegerParameter<T: BinaryInteger & Sendable & Hashable>: Sendable, Hashable {
  package var value: T
  public let address: UInt64
  public let range: ClosedRange<T>
  package var shouldUpdate = false

  public var wrappedValue: T {
    get { return value }
    set { value = max(range.lowerBound, min(newValue, range.upperBound)) }
  }

  public var projectedValue: IntegerParameter<T> {
    get { return self }
    set { self = newValue }
  }

  init(wrappedValue: T, at address: UInt64, range: ClosedRange<T>) {
    self.value = max(range.lowerBound, min(wrappedValue, range.upperBound))
    self.address = address
    self.range = range
  }
}
