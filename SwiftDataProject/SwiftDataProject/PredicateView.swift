//
//  PredicateView.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 23/03/26.
//

import SwiftData
import SwiftUI

struct PredicateView: View {
    
    @Query(filter: #Predicate<User> { user in
        user.city == "London" && user.name.localizedStandardContains("R")
    }, sort: \User.name) var users : [User]
    @Environment(\.modelContext) var modelContext;
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users Pred.")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    for user in users {
                        modelContext.delete(user)
                    }
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    PredicateView()
        .modelContainer(for: User.self, inMemory: false)
}
