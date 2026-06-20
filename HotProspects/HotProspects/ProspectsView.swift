//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Alejandro González on 17/06/26.
//
import AVFoundation
import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, uncontacted, contacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    
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
                List(prospects, selection: $selectedProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                    .swipeActions {
                        Button("Delete", systemImage: "trash") {
                            modelContext.delete(prospect)
                        }
                        .tint(.red)
                        
                        if prospect.isContacted == false {
                            Button("Befriend", systemImage: "person.crop.circle.fill.badge.checkmark") {
                                prospect.isContacted = true
                            }
                            .tint(.blue)
                        } else {
                            Button("Strand in Oblivion", systemImage: "person.crop.circle.badge.xmark") {
                                prospect.isContacted = false
                            }
                        }
                        
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                    .tag(prospect)
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if !selectedProspects.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            delete()
                        }
                        .tint(.red)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "FlipFlop\nflipflop@flop.com", completion: handleScan)
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
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            
            modelContext.insert(person)
        case .failure(let failure):
            print("Scanning flopped: \(failure.localizedDescription)")
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
