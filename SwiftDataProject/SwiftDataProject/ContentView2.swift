//
//  ContentView2.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 24/03/26.
//

import SwiftData
import SwiftUI

struct ContentView2: View {
    @State private var minDateNow = false
    @State private var sortDesc = [SortDescriptor(\User.name), SortDescriptor(\User.joinDate)]
    
    var body: some View {
        UsersView(minimumJoinDate: minDateNow ? .now : .distantPast, sortDesc: sortDesc)
        
        Button("Filter") {
            minDateNow.toggle()
        }
        Menu("Sort") {
            Picker("Sort", selection: $sortDesc) {
                Text("Sort by name")
                    .tag([SortDescriptor(\User.name), SortDescriptor(\User.joinDate)])
                Text("Sort by join date")
                    .tag([SortDescriptor(\User.joinDate), SortDescriptor(\User.name)])
            }
        }
    }
}

#Preview {
    ContentView2()
        .modelContainer(for: User.self)
}
