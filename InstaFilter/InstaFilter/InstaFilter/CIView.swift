//
//  CIView.swift
//  InstaFilter
//
//  Created by Alejandro González on 11/04/26.
//


import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CIView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        image = Image(.example)
        
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.twirlDistortion()
        
        currentFilter.inputImage = beginImage
        
        let amount = 1.0
        
        let inputKeys = currentFilter.inputKeys
        
        if (inputKeys.contains(kCIInputIntensityKey)) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if (inputKeys.contains(kCIInputScaleKey)) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        if (inputKeys.contains(kCIInputRadiusKey)) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        
        guard let filteredRecipe : CIImage = currentFilter.outputImage else { return }
        
        guard let actualImage : CGImage = context.createCGImage(filteredRecipe, from: filteredRecipe.extent) else { return }
        
        let UIimg = UIImage(cgImage: actualImage)
        
        image = Image(uiImage: UIimg)
    }
}

#Preview {
    CIView()
}
