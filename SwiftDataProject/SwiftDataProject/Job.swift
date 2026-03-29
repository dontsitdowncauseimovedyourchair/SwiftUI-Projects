//
//  Job.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 26/03/26.
//

import Foundation
import SwiftData

@Model
class Job {
    var name : String
    var priority : Int
    @Relationship(deleteRule: .cascade) var owner : User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
