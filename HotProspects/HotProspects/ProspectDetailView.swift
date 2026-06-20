//
//  ProspectDetailView.swift
//  HotProspects
//
//  Created by Alejandro González on 19/06/26.
//

import SwiftData
import SwiftUI

struct ProspectDetailView: View {
    @Bindable var prospect: Prospect
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
                .textFieldStyle(.roundedBorder)

            TextField("Email Address", text: $prospect.emailAddress)
                .textFieldStyle(.roundedBorder)
            
            Toggle("Befriended Prospect??", isOn: $prospect.isContacted)
        }
        .padding()
        .clipShape(.rect(cornerRadius: 10))
        .navigationTitle("Edit your prospect")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done", systemImage: "checkmark",role: .confirm) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let prospect = Prospect(name: "SUPERPAPOI", emailAddress: "flip@flipflop.pro", isContacted: false)
    
    ProspectDetailView(prospect: prospect)
        .modelContainer(for: Prospect.self, inMemory: true)
}
