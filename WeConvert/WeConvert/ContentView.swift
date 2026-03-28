//
//  ContentView.swift
//  WeConvert
//
//  Created by Alejandro González on 18/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber: Double = 1
    @State private var typeSelection: ConvType = ConvType.length
    @State private var kindSelection: String = "Kilometers"
    @State private var convertKindSelection: String = "Miles"
    
    @FocusState private var magnitudeFieldFocused: Bool
        
    enum ConvType : String, CaseIterable, Identifiable {
        case length = "Length"
        case temperature = "Temperature"
        case time = "Time"
        case volume = "Volume"
        
        var id: Self { self }
        
        var kinds: [String] {
            switch self {
            case .length:  return ["Meters", "Kilometers", "Feet", "Yards", "Inches", "Miles"]
            case .temperature: return ["Celsius", "Fahrenheit", "Kelvin"]
            case .time: return ["Seconds", "Minutes", "Hours", "Days"]
            case .volume: return ["Liters", "Milliliters", "Cups", "Pints", "Gallons"]
            }
        }
    }
    
    var conversion: Double? {
        if convertKindSelection == kindSelection {
            return inputNumber
        }
        
        switch typeSelection {
            
        case .length:
            let factors = [
                "Meters": 1.0,
                "Kilometers": 1000.0,
                "Feet": 0.3048,
                "Yards": 0.9144,
                "Inches": 0.0254,
                "Miles": 1609.34
            ]
            
            guard let source = factors[kindSelection], let target = factors[convertKindSelection] else {
                return nil
            }
            
            return inputNumber * source / target
            
        case .temperature:
            var celsius: Double
            switch kindSelection {
                case "Celsius": celsius = inputNumber
                case "Fahrenheit": celsius = (inputNumber - 32) * 5.0/9.0
                case "Kelvin": celsius = inputNumber - 273.15
                default: return nil
            }
            
            switch convertKindSelection {
                case "Celsius": return celsius
                case "Fahrenheit": return (celsius * 9.0/5.0) + 32
                case "Kelvin": return celsius + 273.15
                default: return nil
            }
            
        case .time:
            let factors = [
                "Seconds": 1.0,
                "Minutes": 60.0,
                "Hours": 3600.0,
                "Days": 86400.0
            ]
            
            guard let source = factors[kindSelection], let target = factors[convertKindSelection] else {
                return nil
            }
            
            return inputNumber * source / target
            
        case .volume:
            let factors = [
                "Liters": 1.0,
                "Milliliters": 0.001,
                "Cups": 0.236588,
                "Pints": 0.473176,
                "Gallons": 3.78541
            ]
            
            guard let source = factors[kindSelection], let target = factors[convertKindSelection] else {
                return nil
            }
            
            return inputNumber * source / target
        }
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter magnitude") {
                    HStack {
                        TextField("Magnitude", value: $inputNumber, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($magnitudeFieldFocused)
                        Spacer()
                        Text(typeSelection == .temperature ? "°\(kindSelection)" : kindSelection)
                    }
                                        
                    Picker("Type", selection: $typeSelection) {
                        ForEach(ConvType.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker("Kind", selection: $kindSelection) {
                        ForEach(typeSelection.kinds, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Converted Value") {
                    HStack {
                        Text(conversion ?? 0, format: .number.precision(.fractionLength(0...4)))
                        Text(typeSelection == .temperature ? "°\(convertKindSelection)" : convertKindSelection)
                    }
                    
                    Picker("Convert to", selection: $convertKindSelection) {
                        ForEach(typeSelection.kinds, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("FlopConvert")
            .onChange(of: typeSelection) {
                kindSelection = typeSelection.kinds.first ?? ""
                convertKindSelection = typeSelection.kinds.first ?? ""
            }
            .toolbar() {
                if (magnitudeFieldFocused) {
                    Button("Done") {
                        magnitudeFieldFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

