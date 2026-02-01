import KatanaCore
import KatanaFx
import KatanaGoData
import SwiftUI

struct Phaser90EView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var scriptEnable = false
  @State private var speed: Double = 50

  var body: some View {
    Section("Phaser 90E Parameters") {
      Toggle(
        "Script",
        isOn: Binding(
          get: { scriptEnable },
          set: {
            scriptEnable = $0
            viewModel.updateWritableBank(Phaser90EBank(scriptStatus: $0), channel: channel)
          }
        ))
      ParameterSlider(
        title: "Speed",
        value: Binding(
          get: { speed },
          set: {
            speed = $0
            viewModel.updateWritableBank(Phaser90EBank(speed: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: Phaser90EBank.self, channel: channel) else {
      return
    }
    scriptEnable = bank.scriptStatus
    speed = Double(bank.speed)
  }
}

struct Flanger117EView: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var manual: Double = 50
  @State private var width: Double = 50
  @State private var speed: Double = 50
  @State private var regen: Double = 50

  var body: some View {
    Section("Flanger 117E Parameters") {
      ParameterSlider(
        title: "Manual",
        value: Binding(
          get: { manual },
          set: {
            manual = $0
            viewModel.updateWritableBank(Flanger117EBank(manual: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Width",
        value: Binding(
          get: { width },
          set: {
            width = $0
            viewModel.updateWritableBank(Flanger117EBank(width: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Speed",
        value: Binding(
          get: { speed },
          set: {
            speed = $0
            viewModel.updateWritableBank(Flanger117EBank(speed: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Regen",
        value: Binding(
          get: { regen },
          set: {
            regen = $0
            viewModel.updateWritableBank(Flanger117EBank(regen: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: Flanger117EBank.self, channel: channel) else {
      return
    }
    manual = Double(bank.manual)
    width = Double(bank.width)
    speed = Double(bank.speed)
    regen = Double(bank.regen)
  }
}

struct DC30View: View {
  var viewModel: ContentViewModel
  var channel: KatanaGoFxChannel

  @State private var type = DC30Type.chorus
  @State private var inputVolume: Double = 50
  @State private var chorusIntensity: Double = 50
  @State private var echoIntensity: Double = 50
  @State private var repeatTime: Double = 300
  @State private var volume: Double = 50
  @State private var tone: Double = 50
  @State private var outputType = DC30OutputType.dPlusE

  var body: some View {
    Section("DC-30 Parameters") {
      Picker(
        "Type",
        selection: Binding(
          get: { type },
          set: {
            type = $0
            viewModel.updateWritableBank(DC30Bank(type: $0), channel: channel)
          }
        )
      ) {
        ForEach(DC30Type.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      ParameterSlider(
        title: "Input Volume",
        value: Binding(
          get: { inputVolume },
          set: {
            inputVolume = $0
            viewModel.updateWritableBank(DC30Bank(inputVolume: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Chorus Intensity",
        value: Binding(
          get: { chorusIntensity },
          set: {
            chorusIntensity = $0
            viewModel.updateWritableBank(DC30Bank(chorusIntensity: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Repeat Time",
        value: Binding(
          get: { repeatTime },
          set: {
            repeatTime = $0
            viewModel.updateWritableBank(DC30Bank(echoRepeatTime: UInt16($0)), channel: channel)
          }
        ), range: 40...600)
      ParameterSlider(
        title: "Echo Intensity",
        value: Binding(
          get: { echoIntensity },
          set: {
            echoIntensity = $0
            viewModel.updateWritableBank(DC30Bank(echoIntensity: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Volume",
        value: Binding(
          get: { volume },
          set: {
            volume = $0
            viewModel.updateWritableBank(DC30Bank(echoVolume: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      ParameterSlider(
        title: "Tone",
        value: Binding(
          get: { tone },
          set: {
            tone = $0
            viewModel.updateWritableBank(DC30Bank(tone: UInt8($0)), channel: channel)
          }
        ), range: 0...100)
      Picker(
        "Output Type",
        selection: Binding(
          get: { outputType },
          set: {
            outputType = $0
            viewModel.updateWritableBank(DC30Bank(outputType: $0), channel: channel)
          }
        )
      ) {
        ForEach(DC30OutputType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
    }
    .task {
      await loadData()
    }
  }

  private func loadData() async {
    guard let bank = await viewModel.readFxBank(type: DC30Bank.self, channel: channel) else {
      return
    }
    type = bank.type
    inputVolume = Double(bank.inputVolume)
    chorusIntensity = Double(bank.chorusIntensity)
    echoIntensity = Double(bank.echoIntensity)
    repeatTime = Double(bank.echoRepeatTime)
    volume = Double(bank.echoVolume)
    tone = Double(bank.tone)
    outputType = bank.outputType
  }
}
