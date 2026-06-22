//
//  PhaseView.swift
//  Flashzilla
//
//  Created by Alejandro González on 21/06/26.
//

import SwiftUI

struct PhaseView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of:scenePhase) { oldValue, newValue in
                switch(newValue) {
                case .active: print("Active")
                case .inactive: print("Inactive")
                case .background: print("Background")
                @unknown default:
                    print("fourth state of matter")
                }
            }
    }
}

#Preview {
    PhaseView()
}
