import KatanaGoData
import SwiftUI

struct Phaser90EView: View {
  @State private var scriptEnable = false
  @State private var speed: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Phaser 90E Parameters") {
      Toggle("Script", isOn: $scriptEnable)
        .onChange(of: scriptEnable) { _, newValue in
          onUpdate(.phaser90E(.scriptEnable(newValue)))
        }
      ParameterSlider(title: "Speed", value: $speed, range: 0...100) {
        onUpdate(.phaser90E(.speed(UInt8($0))))
      }
    }
  }
}

struct Flanger117EView: View {
  @State private var manual: Double = 50
  @State private var width: Double = 50
  @State private var speed: Double = 50
  @State private var regen: Double = 50

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("Flanger 117E Parameters") {
      ParameterSlider(title: "Manual", value: $manual, range: 0...100) {
        onUpdate(.flanger117E(.manual(UInt8($0))))
      }
      ParameterSlider(title: "Width", value: $width, range: 0...100) {
        onUpdate(.flanger117E(.width(UInt8($0))))
      }
      ParameterSlider(title: "Speed", value: $speed, range: 0...100) {
        onUpdate(.flanger117E(.speed(UInt8($0))))
      }
      ParameterSlider(title: "Regen", value: $regen, range: 0...100) {
        onUpdate(.flanger117E(.regen(UInt8($0))))
      }
    }
  }
}

struct DC30View: View {
  @State private var type = DC30Type.chorus
  @State private var inputVolume: Double = 50
  @State private var intensity: Double = 50
  @State private var repeatTime: Double = 300
  @State private var volume: Double = 50
  @State private var tone: Double = 50
  @State private var outputType = DC30OutputType.dPlusE

  let onUpdate: (ModFxParameter) -> Void

  var body: some View {
    Section("DC-30 Parameters") {
      Picker("Type", selection: $type) {
        ForEach(DC30Type.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: type) { _, newValue in
        onUpdate(.dc30(.type(newValue)))
      }
      ParameterSlider(title: "Input Volume", value: $inputVolume, range: 0...100) {
        onUpdate(.dc30(.inputVolume(UInt8($0))))
      }
      ParameterSlider(title: "Intensity", value: $intensity, range: 0...100) {
        onUpdate(.dc30(.intensity(UInt8($0))))
      }
      ParameterSlider(title: "Repeat Time", value: $repeatTime, range: 0...1000) {
        onUpdate(.dc30(.repeatTime(UInt16($0))))
      }
      ParameterSlider(title: "Volume", value: $volume, range: 0...100) {
        onUpdate(.dc30(.volume(UInt8($0))))
      }
      ParameterSlider(title: "Tone", value: $tone, range: 0...100) {
        onUpdate(.dc30(.tone(UInt8($0))))
      }
      Picker("Output Type", selection: $outputType) {
        ForEach(DC30OutputType.allCases, id: \.self) { type in
          Text("\(type.name)").tag(type)
        }
      }
      .onChange(of: outputType) { _, newValue in
        onUpdate(.dc30(.outputType(newValue)))
      }
    }
  }
}
