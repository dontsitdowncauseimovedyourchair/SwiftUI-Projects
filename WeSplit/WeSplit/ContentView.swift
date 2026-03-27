//
//  ContentView.swift
//  WeSplit
//
//  Created by Alejandro González on 17/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let localCurrency = Locale.current.currency?.identifier ?? "MXN"
    
    let possibleTips = [5, 10, 15, 20, 25, 0]
    
    var billTotal: Double {
        billAmount + (billAmount * (Double(tipPercentage)/100.0))
    }
    
    var totalPerPerson: Double {
        billTotal / Double(numberOfPeople)
    }
  
    var body: some View {
        NavigationStack {
            Form {
                Section("Check") {
                    HStack {
                        Text(localCurrency)
                            .foregroundStyle(.secondary)
                        
                        TextField("Amount", value: $billAmount, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2...100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much will you tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(possibleTips, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                Section("Check total with tip") {
                    Text(billTotal, format: .currency(code: localCurrency))
                        .foregroundStyle(tipPercentage != 25 ? .black : .red)
                }
                
                Section("Total per person") {
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if (amountIsFocused) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
 
