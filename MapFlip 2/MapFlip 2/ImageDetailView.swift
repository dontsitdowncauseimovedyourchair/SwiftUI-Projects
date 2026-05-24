//
//  ImageDetailView.swift
//  MapFlip 2
//
//  Created by Alejandro González on 24/05/26.
//

import SwiftUI

struct ImageDetailView: View {
    var entry: PhotoEntry
    
    var body: some View {
        VStack {
            entry.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
        .padding()
        .navigationTitle(entry.title)
    }
}
