//
//  MapFlip_2App.swift
//  MapFlip 2
//
//  Created by Alejandro González on 17/05/26.
//

import SwiftData
import SwiftUI

@main
struct MapFlip_2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PhotoEntry.self)
    }
}
