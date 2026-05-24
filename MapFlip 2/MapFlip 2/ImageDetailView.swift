//
//  ImageDetailView.swift
//  MapFlip 2
//
//  Created by Alejandro González on 24/05/26.
//

import MapKit
import PhotosUI
import SwiftUI

struct ImageDetailView: View {
    var entry: PhotoEntry
    

    
    var body: some View {
        VStack {
            entry.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            if let location = entry.location {
                Map(initialPosition: MapCameraPosition.region(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)))) {
                    Marker(entry.title, coordinate: location)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .ignoresSafeArea()
        .padding()
        .navigationTitle(entry.title)
    }
}
