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
class PhotoEntry : Identifiable {
    var id = UUID()
    
    @Attribute(.externalStorage) private var photoData: Data
    var title: String
    
    var image: Image {
        if let uiImg = UIImage(data: photoData) {
            return Image(uiImage: uiImg)
        } else {
            return Image(systemName: "image")
        }
        
    }
    
    init(photoData: Data, title: String) {
        self.photoData = photoData
        self.title = title
    }
}
