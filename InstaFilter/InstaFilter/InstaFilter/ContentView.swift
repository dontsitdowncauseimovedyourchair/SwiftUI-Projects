//
//  ContentView.swift
//  InstaFilter
//
//  Created by Alejandro González on 08/04/26.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("The content has officially flopped")
        } actions: {
            Button("Do crazy stuff") {
                
            }
            .buttonStyle(.glassProminent)
        }
    }
    
}

#Preview {
    ContentView()
}
