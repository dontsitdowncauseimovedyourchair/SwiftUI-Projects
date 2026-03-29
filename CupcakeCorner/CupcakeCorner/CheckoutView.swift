//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Alejandro González on 27/01/26.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Total: \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Flopped Encoding Order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let stringData = String(data: data, encoding: .utf8)
            print("Response from server:", stringData ?? "No data")
            
            let orderData = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank You!"
            confirmationMessage = "Successfully ordered \(orderData.quantity)x  \(Order.types[orderData.type]) cupcakes. They're on their way"
        } catch {
            confirmationTitle = "Flopped whilst placing order"
            confirmationMessage = "\(error.localizedDescription)"
        }
        
        showingConfirmation = true
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
