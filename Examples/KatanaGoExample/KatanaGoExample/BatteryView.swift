import KatanaGoData
import SwiftUI

struct BatteryView: View {
  var viewModel: ContentViewModel

  @State private var batteryLevel: Int = 0

  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        
        // Creative Battery Display Header
        ZStack {
          LinearGradient(
            colors: [batteryColor.opacity(0.15), .clear],
            startPoint: .top,
            endPoint: .bottom
          )
          .ignoresSafeArea()
          
          VStack(spacing: 32) {
            // visual Battery Icon
            ZStack {
              // Background Glow
              Circle()
                .fill(batteryColor.opacity(0.1))
                .frame(width: 240, height: 240)
                .blur(radius: 30)
              
              VStack(spacing: 20) {
                // Battery Shape
                HStack(spacing: 6) {
                  ZStack(alignment: .leading) {
                    // Outer Shell
                    RoundedRectangle(cornerRadius: 18)
                      .stroke(Color.primary.opacity(0.15), lineWidth: 4)
                      .frame(width: 150, height: 80)
                    
                    // Segments
                    HStack(spacing: 6) {
                      ForEach(0..<3) { index in
                        RoundedRectangle(cornerRadius: 12)
                          .fill(index < batteryLevel ? 
                                LinearGradient(colors: [batteryColor, batteryColor.opacity(0.8)], startPoint: .top, endPoint: .bottom) : 
                                LinearGradient(colors: [Color.primary.opacity(0.05)], startPoint: .top, endPoint: .bottom))
                          .frame(width: 42, height: 62)
                          .animation(.spring(response: 0.4, dampingFraction: 0.6).delay(Double(index) * 0.05), value: batteryLevel)
                      }
                    }
                    .padding(.horizontal, 7)
                  }
                  
                  // Battery Tip
                  RoundedRectangle(cornerRadius: 6)
                    .fill(Color.primary.opacity(0.15))
                    .frame(width: 10, height: 35)
                }
              }
            }
            .padding(.top, 20)
            
            VStack(spacing: 8) {
              Text(levelDescription)
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundColor(batteryColor)
              
              Text("Power Level")
                .font(.footnote)
                .fontWeight(.black)
                .foregroundColor(.secondary.opacity(0.6))
                .textCase(.uppercase)
                .tracking(3)
            }
          }
        }
        .frame(height: 380)
        
        // Information and Actions
        List {
          Section {
            HStack {
              Label("Sync Status", systemImage: "antenna.radiowaves.left.and.right")
              Spacer()
              Text("Connected")
                .foregroundColor(.green)
                .fontWeight(.medium)
            }
            
            HStack {
              Label("Level Index", systemImage: "number.circle")
              Spacer()
              Text("\(batteryLevel) / 3")
                .foregroundColor(.secondary)
                .monospaced()
            }
          }
          
          Section {
            Button {
              Task {
                await loadBatteryData()
              }
            } label: {
              HStack {
                Spacer()
                Label("Refresh Battery", systemImage: "arrow.clockwise")
                  .fontWeight(.bold)
                Spacer()
              }
              .padding(.vertical, 4)
            }
            .buttonStyle(.borderedProminent)
            .tint(batteryColor)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
          }
        }
        .listStyle(.insetGrouped)
      }
      .navigationTitle("Battery")
      .navigationBarTitleDisplayMode(.inline)
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
    switch batteryLevel {
    case 3: return .green
    case 2: return .yellow
    case 1: return .orange
    default: return .red
    }
  }

  private var levelDescription: String {
    // Mapping the 4 levels (0-3) to the requested states: 
    // empty, two third, three thirds and full
    switch batteryLevel {
    case 3: return "Full"
    case 2: return "Three Thirds"
    case 1: return "Two Thirds"
    case 0: return "Empty"
    default: return "Unknown"
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
