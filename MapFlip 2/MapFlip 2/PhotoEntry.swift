//
//  PhotoEntry.swift
//  MapFlip 2
//
//  Created by Alejandro González on 17/05/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class PhotoEntry {
    var image: Image
    var name: String
    
    init(image: Image, name: String) {
        self.image = image
        self.name = name
    }
}
