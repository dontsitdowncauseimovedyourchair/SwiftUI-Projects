//
//  CustomAlignmentView.swift
//  Layout_n_Geometry
//
//  Created by Alejandro González on 01/07/26.
//

import SwiftUI

//Custom vertical alignment
extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentView: View {
    var body: some View {
        HStack {
            VStack {
                Text("@flopflop")
                Image(uiImage: .checkmark)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
            }
            
            VStack {
                Text("Full name:")
                Text("Mr. Flop")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    CustomAlignmentView()
}
