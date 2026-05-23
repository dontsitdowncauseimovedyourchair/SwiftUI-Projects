//
//  ContentView.swift
//  MapFlip 2
//
//  Created by Alejandro González on 17/05/26.
//

import PhotosUI
import SwiftUI
import SwiftData


struct ContentView: View {
    @Query var entries: [PhotoEntry]
    @State private var selectedImage: PhotosPickerItem?

    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $selectedImage, matching: .all(of: [.images, .depthEffectPhotos, .bursts, .playbackStyle(.imageAnimated)])) {
                    Label("New epic photo", systemImage: "photo")
                }
                List {
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PhotoEntry.self)
}
