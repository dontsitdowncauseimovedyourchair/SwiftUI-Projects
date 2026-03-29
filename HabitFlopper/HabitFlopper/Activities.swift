//
//  Activities.swift
//  HabitFlopper
//
//  Created by Alejandro González on 22/01/26.
//

import Foundation
import Observation

@Observable
class Activities {
    var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: data) {
                activities = decoded
                return
            }
        }
        activities = []
    }
}
