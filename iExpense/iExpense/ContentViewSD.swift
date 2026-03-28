
//
//  ContentViewSD.swift
//  iExpense
//
//  Created by Alejandro González on 09/01/26.
//

import SwiftUI
import SwiftData

@Model
class ExpenseItemSD {
    var id = UUID()
    var name: String
    var type: String
    var price: Double
    
    init(id: UUID = UUID(), name: String, type: String, price: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.price = price
    }
}

struct ContentViewSD: View {
    
    @Query var expenses : [ExpenseItemSD]
    @Environment(\.modelContext) var modelContext
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                if (expenses.contains { item in
                    item.type == "Personal"
                }) {
                    Section("Personal") {
                        ForEach(expenses) { item in
                            if (item.type == "Personal") {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "MXN"))
                                        .foregroundStyle(item.price < 10 ? .green : item.price < 100 ? .orange : .red)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                if (expenses.contains { item in
                    item.type == "Business"
                }) {
                    Section("Business") {
                        ForEach(expenses) { item in
                            if (item.type == "Business") {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.price, format: .currency(code: Locale.current.currency?.identifier ?? "MXN"))
                                        .foregroundStyle(item.price < 10 ? .green : item.price < 100 ? .orange : .red)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddViewSD()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(expenses[offset])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItemSD.self)
}
