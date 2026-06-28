//
//  Card.swift
//  Flashzilla
//
//  Created by Alejandro González on 22/06/26.
//


import SwiftData
import Foundation

@Model
class Card {
    var prompt: String
    var answer: String

    init(prompt: String, answer: String) {
        self.prompt = prompt
        self.answer = answer
    }
}

//When changing into SwiftData I made Card a class which made my ContentView logic behave weirdly due to the reference passing stuff.
//So I made this struct to help avoid weird behaviours
struct SessionCard: Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String

    static let example = SessionCard(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

//This cool trick to keep things neatly.
extension Card {
    func asSessionCard() -> SessionCard {
        SessionCard(prompt: prompt, answer: answer)
    }
}

