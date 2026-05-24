//
//  PhotoEntry.swift
//  MapFlip 2
//
//  Created by Alejandro González on 17/05/26.
//

import Foundation
import PhotosUI
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
    
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?
    
    var location: CLLocationCoordinate2D? {
        if let longitude, let latitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return nil
    }
    
    init(photoData: Data, title: String, latitude: CLLocationDegrees?, longitude: CLLocationDegrees?) {
        self.photoData = photoData
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
}
