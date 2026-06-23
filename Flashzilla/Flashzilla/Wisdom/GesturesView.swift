//
//  GesturesView.swift
//  Flashzilla
//
//  Created by Alejandro González on 21/06/26.
//

import SwiftUI

struct GesturesView: View {
    @State private var currentAmountScale = 0.0
    @State private var finalAmountScale = 1.0
    
    @State private var currentAmountRotation = Angle.zero
    @State private var finalAmountRotation = Angle.zero

    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            //COLUMN1
            VStack {
                Spacer()
                
                Text("DOUBLE TAP ME!!")
                    .onTapGesture(count: 2) {
                        print("Double tappeado!!")
                    }
                
                Spacer()
                
                Text("LONG PRESS ME!!")
                    .onLongPressGesture(minimumDuration: 2) {
                        print("Long presseddd")
                    } onPressingChanged: { inProgress in
                        print("In progress is \(inProgress)")
                    }
                
                Spacer()
                
                Text("HELLO SCALE")
                    .scaleEffect(finalAmountScale + currentAmountScale )
                    .gesture(
                        MagnifyGesture()
                            .onChanged { value in
                                currentAmountScale = value.magnification - 1
                            }
                            .onEnded { value in
                                finalAmountScale += currentAmountScale
                                currentAmountScale = 0
                            }
                    )
                    .padding()
                
                Spacer()
                
                Text("HELLO ROTATE")
                    .rotationEffect(finalAmountRotation + currentAmountRotation)
                    .gesture(
                        RotateGesture()
                            .onChanged({ value in
                                currentAmountRotation = value.rotation
                            })
                            .onEnded({ value in
                                finalAmountRotation += value.rotation
                                currentAmountRotation = Angle.zero
                            })
                        
                        
                    )
                
                Spacer()
            }
            
            //COLUMN2
            VStack {
                Spacer()
                
                VStack {
                    Text("Hello world!")
                        .onTapGesture {
                            //Prefers this one
                            print("Text Tapped")
                        }
                }
                .onTapGesture {
                    print("VStack tapped")
                }
                
                Spacer()
                
                VStack {
                    Text("HELLO FLOP!!")
                        .onTapGesture {
                            print("Text tapped")
                        }
                }
                .highPriorityGesture(
                    TapGesture()
                        .onEnded({ _ in
                            print("VStack Tapped")
                        })
                )
                
                Spacer()
                
                VStack {
                    Text("HELLO FLOP!!")
                        .onTapGesture {
                            print("Text tapped")
                        }
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded({ _ in
                            print("VStack Tapped")
                        })
                )
                
                Spacer()
                
                let dragGesture = DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                            isDragging = false
                        }
                    }
                
                let pressGesture = LongPressGesture()
                    .onEnded { value in
                        withAnimation {
                            isDragging = true
                        }
                    }
                
                
                let combined = pressGesture.sequenced(before: dragGesture)
                
                Circle()
                    .fill(.red)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1.0)
                    .offset(offset)
                    .gesture(combined)
                
                Spacer()
            }
        }
    }
}

#Preview {
    GesturesView()
}
