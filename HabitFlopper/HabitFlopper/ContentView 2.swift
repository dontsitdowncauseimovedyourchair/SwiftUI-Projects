//
//  ContentView.swift
//  HabitFlopper
//
//  Created by Alejandro González on 22/01/26.
//

import SwiftUI
import ElegantEmojiPicker

struct ActivityCard : View {
    @Binding var activity: Activity
    @State var hobbys: Activities
    
    var body: some View {
        NavigationLink {
            ActivityDetailView(activity: $activity, hobbies: hobbys)
        } label: {
            VStack {
                HStack {
                    Text(activity.emoji ?? "📝")
                        .font(.system(size: 50))
                        .padding()
                    Spacer()
                }
                Spacer()
                Group {
                    Text(activity.name)
                        .font(.title3.bold())
                    HStack(alignment: .center) {
                        Button {
                            if activity.timesCompleted == 0 {
                                return
                            }
                            activity.timesCompleted -= 1
                        } label: {
                            Image(systemName: "minus")
                                .frame(width: 30, height: 30)
                                .background(.gray.opacity(0.3))
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        
                        Spacer()
                        
                        Text("\(activity.timesCompleted)")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button {
                            activity.timesCompleted += 1
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 30, height: 30)
                                .background(.gray.opacity(0.3))
                                .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                    Text("Times done")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, minHeight: 170, maxHeight: 200)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
            }
            .padding(2)
        }
    }
}

struct ContentView: View {
    @State private var hobbys = Activities()
    
    @State private var showingAddSheet = false
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach($hobbys.activities) { $activity in
                        ActivityCard(activity: $activity, hobbys: hobbys)
                    }
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showingAddSheet) {
                AddView(hobbies: hobbys)
            }
            .navigationTitle("Habit Bopper")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
    
    func clearActivities() {
        hobbys.activities.removeAll()
    }
    
    func deleteActivity(activity: Activity) {
        if let index = hobbys.activities.firstIndex(where: { act in
            activity.id == act.id
        }) {
            hobbys.activities.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
