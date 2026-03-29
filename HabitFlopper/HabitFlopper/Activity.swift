//
//  Activity.swift
//  HabitFlopper
//
//  Created by Alejandro González on 22/01/26.
//

import Foundation
import ElegantEmojiPicker

struct Activity: Hashable, Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var timesCompleted: Int
    var emoji: String?
}
