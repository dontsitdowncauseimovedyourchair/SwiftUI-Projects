//
//  ImageSavingView.swift
//  MapFlip 2
//
//  Created by Alejandro González on 23/05/26.
//

import SwiftUI

struct ImageSavingView: View {
    var image: Image
    @State private var inTitle = "";
    
    var onSave: (String) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                image
                    .resizable()
                    .scaledToFit()
                
                TextField("Title", text: $inTitle)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(inTitle)
                    }
                }
            }
        }
    }
}
