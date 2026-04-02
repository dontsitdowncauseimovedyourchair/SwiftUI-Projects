//
//  FriendifyApp.swift
//  Friendify
//
//  Created by Alejandro González on 31/03/26.
//

import SwiftData
import SwiftUI

@main
struct FriendifyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
