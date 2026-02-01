import SwiftUI

struct ParameterSlider: View {
  let title: String
  @Binding var value: Double
  let range: ClosedRange<Double>

  var body: some View {
    VStack(alignment: .leading) {
      Text("\(title): \(Int(value))")
      Slider(value: $value, in: range)
    }
  }
}
