//
//  ContextMenuView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//

import SwiftUI

struct ContextMenuView: View {
    @State private var bgColor = Color.red
    var body: some View {
        Text("HOLA FLOPS")
            .padding()
            .background(bgColor)
            .foregroundStyle(.white)
        
        Text("WHAT THE FRESH")
            .padding()
            .contextMenu {
                Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                    bgColor = .red
                }
                
                Button("Blue") {
                    bgColor = .blue
                }
                
                Button("Green") {
                    bgColor = .green
                }
            }
    }
}

#Preview {
    ContextMenuView()
}
