//
//  AddView.swift
//  HabitFlopper
//
//  Created by Alejandro González on 22/01/26.
//

import SwiftUI
import ElegantEmojiPicker

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    var hobbies: Activities
    @State private var hobbyName = ""
    @State private var description = ""
    @State private var timesCompleted = ""
    @State private var selectedEmoji: Emoji?
    
    @State private var isEmojiPickerPresented = false
    
    @FocusState private var isTextFocused
    @FocusState private var isNumberFocused
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Icon") {
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            isEmojiPickerPresented = true
                        } label: {
                            Text(selectedEmoji?.emoji ?? "📝")
                                .font(.system(size: 100))
                        }
                        Spacer()
                    }
                }
                
                Section("Details") {
                    TextField("Hobby", text: $hobbyName)
                        .focused($isTextFocused)
                    TextField("Description (optional)", text: $description, axis: .vertical)
                        .frame(minHeight: 50)
                    TextField("Times Completed", text: $timesCompleted)
                        .focused($isNumberFocused)
                        .keyboardType(.numberPad)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                if isNumberFocused {
                                    Spacer()
                                    Button("Done") {
                                        isNumberFocused = false
                                    }
                                }
                            }
                        }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Add Hobby")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addHobby()
                    }
                    .foregroundStyle(.blue)
                }
            }
            .emojiPicker(isPresented: $isEmojiPickerPresented, selectedEmoji: $selectedEmoji)
            .onAppear {
                isTextFocused = true
            }
        }
    }
    
    func addHobby() {
        if (hobbyName.isEmpty) {
            return
        }
        
        hobbies.activities.append(Activity(name: hobbyName, description: description, timesCompleted: Int(timesCompleted) ?? 0, emoji: selectedEmoji?.emoji ?? "📝"))
        dismiss()
    }
}

#Preview {
    AddView(hobbies: Activities())
}
