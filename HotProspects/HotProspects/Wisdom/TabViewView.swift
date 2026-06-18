//
//  TabViewView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//

import SwiftUI

struct TabViewView: View {
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("One", systemImage: "arrow.down", value: "One") {
                Button("Go to tab 2") {
                    selectedTab = "Two"
                }
            }
            //Programmatically goes to two
            Tab("Two", systemImage: "arrow.up", value: "Two") {
                Text("HOLA")
            }
        }
    }
}

#Preview {
    TabViewView()
}
