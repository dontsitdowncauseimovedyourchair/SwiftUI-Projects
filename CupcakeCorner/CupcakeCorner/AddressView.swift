//
//  SwiftUIView.swift
//  CupcakeCorner
//
//  Created by Alejandro González on 27/01/26.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            TextField("Name", text: $order.name)
            TextField("Street Address", text: $order.streetAddress)
            TextField("City", text: $order.city)
            TextField("Zip Code", text: $order.zip)
            
            Section {
                NavigationLink("Check Out") {
                    CheckoutView(order: order)
                }
                .foregroundStyle(.blue)
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
}
