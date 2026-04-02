//
//  Friend.swift
//  Friendify
//
//  Created by Alejandro González on 31/03/26.
//

import SwiftData
import Foundation

//struct Friend : Hashable, Identifiable, Codable {
//    let id: UUID
//    var name: String
//    
//    init(id: UUID, name: String) {
//        self.id = id
//        self.name = name
//    }
//}

@Model
class Friend : Codable {
    var id : UUID
    var name : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
    }
}
