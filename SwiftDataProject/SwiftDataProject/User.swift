//
//  User.swift
//  SwiftDataProject
//
//  Created by Alejandro González on 20/03/26.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate : Date
    var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
