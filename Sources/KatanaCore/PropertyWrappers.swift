@propertyWrapper
public struct Parameter<T: Sendable & Hashable>: Sendable, Hashable, CustomStringConvertible,
  CustomDebugStringConvertible
{
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

  public var description: String {
    "\(wrappedValue)"
  }

  public var debugDescription: String {
    "\(wrappedValue)"
  }
}

@propertyWrapper
public struct IntegerParameter<T: BinaryInteger & Sendable & Hashable>:
  Sendable, Hashable, CustomStringConvertible, CustomDebugStringConvertible
{
  package var value: T
  public let address: UInt32
  public let range: ClosedRange<T>
  public let offsetFromMin: Bool
  package var updated = false

  public var wrappedValue: T {
    get { return value + (offsetFromMin ? range.lowerBound : 0) }
    set {
      let offset = offsetFromMin ? range.lowerBound : 0
      value = max(range.lowerBound, min(newValue, range.upperBound)) - offset
      updated = true
    }
  }

  public var projectedValue: IntegerParameter<T> {
    get { return self }
    set { self = newValue }
  }

  public init(
    wrappedValue: T, at address: UInt32, range: ClosedRange<T>, offsetFromMin: Bool = false
  ) {
    self.value =
      max(range.lowerBound, min(wrappedValue, range.upperBound))
      - (offsetFromMin ? range.lowerBound : 0)
    self.address = address
    self.range = range
    self.offsetFromMin = offsetFromMin
  }

  public var description: String {
    "\(wrappedValue)"
  }

  public var debugDescription: String {
    "\(wrappedValue)"
  }
}
