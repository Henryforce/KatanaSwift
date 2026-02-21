//
//  USBSettingsView.swift
//  KatanaGoExample
//

import KatanaGoData
import SwiftUI

struct USBSettingsView: View {
  var viewModel: ContentViewModel

  @State private var inputLevel: Double = 50
  @State private var outputLevel: Double = 50
  @State private var loopback = false

  var body: some View {
    NavigationView {
      Form {
        Section("Levels") {
          parameterSlider(title: "Input Level", value: $inputLevel, range: 0...100) { newValue in
            updateBank(inputLevel: UInt8(newValue))
          }

          parameterSlider(title: "Output Level", value: $outputLevel, range: 0...100) { newValue in
            updateBank(outputLevel: UInt8(newValue))
          }
        }

        Section("Mode") {
          Toggle(
            "Loopback",
            isOn: Binding(
              get: { loopback },
              set: { newValue in
                loopback = newValue
                updateBank(loopback: newValue)
              }
            ))
        }
      }
      .navigationTitle("USB Settings")
      .task {
        await loadUSBSettingsData()
      }
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            dismissAction()
          }
        }
      }
    }
  }

  @Environment(\.dismiss) private var dismissAction

  private func parameterSlider(
    title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    onUpdate: @escaping (Double) -> Void
  ) -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text(title)
        Spacer()
        Text("\(Int(value.wrappedValue))")
          .foregroundColor(.secondary)
      }
      Slider(
        value: Binding(
          get: { value.wrappedValue },
          set: {
            value.wrappedValue = $0
            onUpdate($0)
          }
        ), in: range)
    }
  }

  private func updateBank(
    inputLevel: UInt8? = nil,
    outputLevel: UInt8? = nil,
    loopback: Bool? = nil
  ) {
    let bank = USBSettingsBank(
      inputLevel: inputLevel ?? UInt8(self.inputLevel),
      outputLevel: outputLevel ?? UInt8(self.outputLevel),
      loopback: loopback ?? self.loopback
    )
    viewModel.updateWritableBank(bank)
  }

  private func loadUSBSettingsData() async {
    guard let bank = await viewModel.readBank(type: USBSettingsBank.self) else { return }

    inputLevel = Double(bank.inputLevel)
    outputLevel = Double(bank.outputLevel)
    loopback = bank.loopback
  }
}

#Preview {
  USBSettingsView(viewModel: ContentViewModel())
}
