//
//  EditCards.swift
//  Flashzilla
//
//  Created by Alejandro González on 26/06/26.
//

import SwiftData
import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var storedCards: [Card]
    
    
    enum Field { case prompt, answer }
    @FocusState private var focusedField: Field?

    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                        .focused($focusedField, equals: .prompt)
                    TextField("Answer", text: $newAnswer)
                        .focused($focusedField, equals: .answer)
                }
                Section {
                    Button("Add Card", action: addCard)
                }
                
                Section {
                    ForEach(storedCards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func done() {
        addCard()
        dismiss()
    }
    
    func addCard() {
        focusedField = nil
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else {
            return
        }
        
        newPrompt = ""
        newAnswer = ""
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        modelContext.insert(card)
    }
    
    func removeCards(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(storedCards[index])
        }
    }
}

#Preview {
    EditCards()
}
