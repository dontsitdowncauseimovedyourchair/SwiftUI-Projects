//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 20/03/26.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
