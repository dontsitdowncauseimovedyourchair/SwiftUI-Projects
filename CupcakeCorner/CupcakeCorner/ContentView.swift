//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alejandro González on 26/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 1...100)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                NavigationLink("Delivery Details") {
                    AddressView(order: order)
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}

