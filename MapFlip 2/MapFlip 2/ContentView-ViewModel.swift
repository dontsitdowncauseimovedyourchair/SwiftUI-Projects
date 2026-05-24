//
//  ContentView-ViewModel.swift
//  MapFlip 2
//
//  Created by Alejandro González on 17/05/26.
//


import PhotosUI
import SwiftData
import SwiftUI

extension ContentView {
    @Observable
    @MainActor
    class ViewModel {
        
        var selectedImage: PhotosPickerItem? {
            didSet {
                    loadData(from: selectedImage)
            }
        }
        
        var selectedData: Data?
        
        func loadData(from item : PhotosPickerItem?) {
            if let item {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        selectedData = data
                    }
                }
            } else {
                selectedData = nil
            }
        }
        
        func loadImage() -> Image {
            if let selectedData, let uiImg = UIImage(data: selectedData) {
                return Image(uiImage: uiImg)
            }
            
            return Image("exclamationmark.warninglight")
        }
    }
}
