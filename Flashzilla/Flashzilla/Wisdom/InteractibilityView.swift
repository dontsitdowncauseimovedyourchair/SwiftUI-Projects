//
//  InteractibilityView.swift
//  Flashzilla
//
//  Created by Alejandro González on 21/06/26.
//

import SwiftUI

struct InteractibilityView: View {
    var body: some View {
        Spacer()
        
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Circle tapped!")
                }
                //Circle is ignored
                .allowsHitTesting(false)
        }
        
        Spacer()
        
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped!")
        }
        
        Spacer()
    }
}

#Preview {
    InteractibilityView()
}
