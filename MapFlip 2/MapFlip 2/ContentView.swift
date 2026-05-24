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
    @Environment(\.modelContext) var modelContext
    @Query var entries: [PhotoEntry]
    @State private var showingTitleMenu = false
    
    @State private var viewModel = ViewModel()
    
        
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(entries) { entry in
                        NavigationLink(value: entry, label: {
                            VStack {
                                entry.image
                                    .resizable()
                                    .scaledToFit()
                                
                                Text(entry.title)
                            }
                        })
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let entry = entries[index]
                            modelContext.delete(entry)
                        }
                        try? modelContext.save()
                    }
                }
                .navigationLinkIndicatorVisibility(.hidden)
                
                PhotosPicker(selection: $viewModel.selectedImage, matching: .any(of: [.images, .depthEffectPhotos, .bursts, .playbackStyle(.imageAnimated)])) {
                    Label("New epic photo", systemImage: "photo")
                }
                .photosPickerStyle(.presentation)
                .padding()
            }
            .onChange(of: viewModel.selectedImage) {
                if let img = viewModel.selectedImage {
                    showingTitleMenu = true
                }
            }
            .sheet(isPresented: $showingTitleMenu) {
                ImageSavingView(image: viewModel.loadImage() ) { title in
                    Task {
                        let entry = PhotoEntry(photoData: viewModel.selectedData ?? Data(), title: title)
                        modelContext.insert(entry)
                        print("Saved entry!")
                    }
                }
                .presentationDetents([.medium])
            }
            .navigationTitle("MapFlip 2")
            .navigationDestination(for: PhotoEntry.self) { entry in
                ImageDetailView(entry: entry)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PhotoEntry.self)
}
