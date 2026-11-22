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

  /// Sets the decoded wire value without marking the parameter as dirty (`updated`).
  package mutating func setDecodedValue(_ rawValue: T) {
    self.value = rawValue
    self.updated = false
  }

  public static func == (lhs: Parameter<T>, rhs: Parameter<T>) -> Bool {
    lhs.value == rhs.value && lhs.address == rhs.address
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(value)
    hasher.combine(address)
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

  /// Sets the decoded raw wire value directly (without subtracting `range.lowerBound` again
  /// and without marking the parameter as dirty).
  package mutating func setDecodedValue(_ rawValue: T) {
    let offset = offsetFromMin ? range.lowerBound : 0
    let minRaw = range.lowerBound - offset
    let maxRaw = range.upperBound - offset
    self.value = max(minRaw, min(rawValue, maxRaw))
    self.updated = false
  }

  public static func == (lhs: IntegerParameter<T>, rhs: IntegerParameter<T>) -> Bool {
    lhs.value == rhs.value
      && lhs.address == rhs.address
      && lhs.range == rhs.range
      && lhs.offsetFromMin == rhs.offsetFromMin
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(value)
    hasher.combine(address)
    hasher.combine(range)
    hasher.combine(offsetFromMin)
  }

  public var description: String {
    "\(wrappedValue)"
  }

  public var debugDescription: String {
    "\(wrappedValue)"
  }
}
