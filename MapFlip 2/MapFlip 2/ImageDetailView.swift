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
                .scaledToFill()
                .clipped()
                .containerRelativeFrame(.vertical, count: 3, span: 2, spacing: 0)

            if let location = entry.location {
                Map(initialPosition: MapCameraPosition.region(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))) {
                    Marker(entry.title, coordinate: location)
                }
                .frame(maxWidth: .infinity)
                .containerRelativeFrame(.vertical, count: 3, span: 1, spacing: 0)
            }
        }
        .ignoresSafeArea(edges: [.bottom, .horizontal])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(entry.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
