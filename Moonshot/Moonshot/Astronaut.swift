//
//  Astronaut.swift
//  Moonshot
//
//  Created by Alejandro González on 13/01/26.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
