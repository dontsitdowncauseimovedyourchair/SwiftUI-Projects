//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 20/03/26.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    @Query(sort: \User.name) var users : [User]
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
                    var user = User(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path.append(user)
                }
            }
            .navigationTitle("UserPro")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
