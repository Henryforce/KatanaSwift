//
//  BatteryView.swift
//  KatanaGoExample
//

import KatanaGoData
import SwiftUI

struct BatteryView: View {
  var viewModel: ContentViewModel

  @State private var batteryLevel: Int = 0

  // TODO: update battery display to cover only 4 levels: full, 2/3, 1/3 and empty.
  var body: some View {
    NavigationView {
      Form {
        Section("Status") {
          HStack {
            Text("Battery Level")
            Spacer()
            Text("\(batteryLevel)")
              .foregroundColor(batteryColor)
              .bold()
          }

          ProgressView(value: Double(batteryLevel), total: 3)
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
    if batteryLevel >= 3 {
      return .green
    } else if batteryLevel >= 2 {
      return .yellow
    } else if batteryLevel >= 1 {
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
