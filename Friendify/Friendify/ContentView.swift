//
//  ContentView.swift
//  Friendify
//
//  Created by Alejandro González on 31/03/26.
//

import SwiftData
import SwiftUI

struct UserCard: View {
    var user: User
    
    var body: some View {
        NavigationLink {
            UserDetailView(user: user)
        } label: {
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text(user.isActive ? "⦿ Active" : "⦿ Offline")
                    .foregroundStyle(user.isActive ? .green : .red)
            }
        }
    }
}

struct ContentView: View {

    @Environment(\.modelContext) var modelContext
    @Query var users : [User]
    
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                UserCard(user: user)
            }
            .task {
                await fetchUsers()
            }
            .navigationTitle("Friendify")
        }
    }
    
    func fetchUsers() async {
        guard users.isEmpty else {
            print("Users not empty")
            return
        }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
                        
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decoded = try? decoder.decode([User].self, from: data) {
                for user in decoded {
                    modelContext.insert(user)
                }
            } else {
                print("Failed to decode, JSON and data model missmatch")
            }
            
        } catch {
            print("Flopped: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
