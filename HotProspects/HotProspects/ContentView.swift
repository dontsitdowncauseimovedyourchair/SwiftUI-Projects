//
//  ContentView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Everyone", systemImage: "person.3") {
                ProspectsView(filter: .none)
            }
            
            Tab("Contacted", systemImage: "checkmark.circle") {
                ProspectsView(filter: .contacted)
            }
            
            Tab("Strangers Dangers", systemImage: "questionmark.diamond") {
                ProspectsView(filter: .uncontacted)
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
