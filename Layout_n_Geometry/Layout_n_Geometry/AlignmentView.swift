//
//  AlignmentView.swift
//  Layout_n_Geometry
//
//  Created by Alejandro González on 01/07/26.
//

import SwiftUI

struct AlignmentView: View {
    var body: some View {
        Spacer()
        
        VStack(alignment: .leading) {
            Text("Hello, world!")
                .alignmentGuide(.leading) { ViewDimensions in
                    ViewDimensions[.trailing]
                }
            Text("This is a longer line of text")
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
        
        Spacer()
        
        //Cool effect, offseting the leading edge
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        Double(position) * -10
                    }
            }
        }
        .background(.red)
       .frame(width: 400, height: 400)
       .background(.blue)
        
        Spacer()
    }
}

#Preview {
    AlignmentView()
}
