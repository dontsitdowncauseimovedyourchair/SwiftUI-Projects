//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Alejandro González on 17/06/26.
//

import SwiftData
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, uncontacted, contacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    let filter: FilterType
    
    var title : String {
        switch filter {
        case .none:
            return "Everyone"
        case .uncontacted:
            return "Strangers Dangers"
        case .contacted:
            return "Contacted"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(prospects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button("Scan", systemImage: "qrcode.viewfinder") {
                    let prospect = Prospect(name: "Flop", emailAddress: "flop@flipflop.com", isContacted: false)
                    modelContext.insert(prospect)
                }
            }
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate { prospect in
                prospect.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
