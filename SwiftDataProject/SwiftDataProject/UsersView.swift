//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 24/03/26.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    @Query var users : [User]
    
    var body: some View {
        List(users) { user in
            Section {
                Text(user.name)
                Text("Joined \(user.joinDate.formatted(date: .numeric, time: .omitted))")
            }
        }
    }
    
    init(minimumJoinDate: Date, sortDesc: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortDesc)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortDesc: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
