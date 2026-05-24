//
//  ImageSavingView.swift
//  MapFlip 2
//
//  Created by Alejandro González on 23/05/26.
//

import SwiftUI

struct ImageSavingView: View {
    @Environment(\.dismiss) var dismiss
    
    var image: Image
    @State private var inTitle = "";
    
    var onSave: (String) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $inTitle)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                image
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle("Title your photo")
            .padding()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(inTitle)
                        dismiss()
                    }
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                }
            }
            Spacer()
        }
    }
}
