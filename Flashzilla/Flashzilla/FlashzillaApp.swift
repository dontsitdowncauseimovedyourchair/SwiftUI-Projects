//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Alejandro González on 21/06/26.
//

import SwiftData
import SwiftUI

@main
struct FlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
