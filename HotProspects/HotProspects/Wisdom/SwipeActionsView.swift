//
//  SwipeActionsView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//

import SwiftUI

struct SwipeActionsView: View {
    var body: some View {
        List {
            Text("FLIP FLOP")
                .swipeActions(edge: .trailing) {
                    Button("Message", systemImage: "message", role: .destructive) {
                        print("Flip")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Flop", systemImage: "pin") {
                        print("Flop")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    SwipeActionsView()
}
