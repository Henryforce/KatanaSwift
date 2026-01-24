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

  init(wrappedValue: T, at address: UInt32) {
    self.value = wrappedValue
    self.address = address
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

  init(wrappedValue: T, at address: UInt32, range: ClosedRange<T>) {
    self.value = max(range.lowerBound, min(wrappedValue, range.upperBound))
    self.address = address
    self.range = range
  }
}
