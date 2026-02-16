//
//  BatteryView.swift
//  KatanaGoExample
//

import KatanaGoData
import SwiftUI

struct BatteryView: View {
  var viewModel: ContentViewModel

  @State private var batteryLevel: Int = 0

  var body: some View {
    NavigationView {
      Form {
        Section("Status") {
          HStack {
            Text("Battery Level")
            Spacer()
            Text("\(batteryLevel)%")
              .foregroundColor(batteryColor)
              .bold()
          }

          ProgressView(value: Double(batteryLevel), total: 100)
            .tint(batteryColor)
        }
        
        Section {
          Button {
            Task {
              await loadBatteryData()
            }
          } label: {
            HStack {
              Spacer()
              Text("Refresh")
              Spacer()
            }
          }
        }
      }
      .navigationTitle("Battery")
      .task {
        await loadBatteryData()
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

  private var batteryColor: Color {
    if batteryLevel > 50 {
      return .green
    } else if batteryLevel > 20 {
      return .orange
    } else {
      return .red
    }
  }

  private func loadBatteryData() async {
    guard let bank = await viewModel.readBank(type: BatteryBank.self) else { return }
    batteryLevel = Int(bank.level)
  }
}

// #Preview {
//   BatteryView(viewModel: ContentViewModel())
// }
