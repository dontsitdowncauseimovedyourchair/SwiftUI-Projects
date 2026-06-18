//
//  PushNotisView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//

import SwiftUI
import UserNotifications

struct PushNotisView: View {
    var body: some View {
        VStack {
            Button("Request Notifications") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
            
            Button("Schedule Notifications") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

#Preview {
    PushNotisView()
}
