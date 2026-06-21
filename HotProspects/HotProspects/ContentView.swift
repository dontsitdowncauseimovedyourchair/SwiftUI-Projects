//
//  ContentView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var isSortingByMostRecent = false
    
    var body: some View {
        TabView {
            Tab("Everyone", systemImage: "person.3") {
                ProspectsView(filter: .none, isSortingByMostRecent: $isSortingByMostRecent)
            }
            
            Tab("Contacted", systemImage: "checkmark.circle") {
                ProspectsView(filter: .contacted, isSortingByMostRecent: $isSortingByMostRecent)
            }
            
            Tab("Strangers Dangers", systemImage: "questionmark.diamond") {
                ProspectsView(filter: .uncontacted, isSortingByMostRecent: $isSortingByMostRecent)
            }
            
            Tab("Me", systemImage: "person.crop.square") {
                MeView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
