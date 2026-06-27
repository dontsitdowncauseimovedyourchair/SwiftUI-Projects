//
//  Card.swift
//  Flashzilla
//
//  Created by Alejandro González on 22/06/26.
//

import Foundation


struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
