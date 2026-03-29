//
//  ActivityDetailView.swift
//  HabitFlopper
//
//  Created by Alejandro González on 22/01/26.
//

import SwiftUI
import ElegantEmojiPicker

struct HorizontalDivider : View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.tertiary)
            .padding(.vertical)
    }
}

struct ActivityDetailView: View {
    @Binding var activity: Activity
    let hobbies: Activities
    
    @State private var isEditingDescription = false
    @FocusState private var isEditFocused
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isEmojiPickerShown = false
    @State private var selectedEmoji: Emoji?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Icon")
                    .font(.title2.bold())
                
                Button {
                    isEmojiPickerShown = true
                } label: {
                    Text(activity.emoji ?? "📝")
                        .font(.system(size: 80))
                        .padding(5)
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.bottom, 10)
                
                HStack(spacing: 15) {
                    Text("Description")
                        .font(.title2.bold())
                        .padding(.bottom, 5)
                    if !isEditingDescription {
                        Button {
                            isEditingDescription = true
                            isEditFocused = true
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width:20, height: 20)
                        }
                    }
                }
                
                if (!isEditingDescription) {
                    Text(activity.description)
                } else {
                    TextField("Descritpion", text: $activity.description)
                        .padding()
                        .background(.gray.opacity(0.25))
                        .focused($isEditFocused)
                }
                
                HorizontalDivider()
                
                Stepper("\(activity.timesCompleted) times completed", value: $activity.timesCompleted)
            }
        }
        .padding()
        .navigationTitle($activity.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isEditingDescription {
                Button("Done") {
                    isEditFocused = false
                    isEditingDescription = false
                }
            }
        }
        .emojiPicker(isPresented: $isEmojiPickerShown, selectedEmoji: $selectedEmoji)
        .onChange(of: selectedEmoji) { oldValue, newValue in
            activity.emoji = newValue?.emoji ?? "📝"
        }
        
        VStack(alignment: .center) {
            Button("Delete Hobby", systemImage: "trash", role: .destructive) {
                deleteActivity()
            }
        }
    }
    
    func deleteActivity() {
        if let index = hobbies.activities.firstIndex(where: { act in
            activity.id == act.id
        }) {
            hobbies.activities.remove(at: index)
        }
        dismiss()
    }
}

#Preview {
    let hobbies = Activities()
    hobbies.activities.append(Activity(name: "Test", description: "Test desc", timesCompleted: 12, emoji: "😀"))
    return NavigationStack { ActivityDetailView(activity: .constant(hobbies.activities[0]), hobbies: hobbies)
    }
}
