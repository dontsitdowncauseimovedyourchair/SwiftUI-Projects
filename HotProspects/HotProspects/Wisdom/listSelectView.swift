//
//  listSelectView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//

import SwiftUI

struct listSelectView: View {
    let users = ["Alexander", "Bartolomeu", "Carl"]
    @State private var selection = Set<String>()
    
    var body: some View {
        
        VStack {
            List(users, id: \.self, selection: $selection) { user in
                Text(user)
            }
            
            if !selection.isEmpty {
                Text("Selection is \(selection.formatted())")
            }
        }
        .padding()
        
        
    }
}

#Preview {
    listSelectView()
}
