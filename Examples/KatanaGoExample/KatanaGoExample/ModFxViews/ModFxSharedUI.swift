import SwiftUI

struct ParameterSlider: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let onUpdate: (Double) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title): \(Int(value))")
            Slider(value: $value, in: range)
                .onChange(of: value) { _, newValue in
                    onUpdate(newValue)
                }
        }
    }
}
