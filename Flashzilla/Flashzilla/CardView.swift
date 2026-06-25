//
//  CardView.swift
//  Flashzilla
//
//  Created by Alejandro González on 22/06/26.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero

    let card: Card
    
    var removalCallable: (()->Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor ?
                        .white
                    :
                        .white.opacity(1-Double(abs(offset.width / 100)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor ?
                        nil
                    :
                        RoundedRectangle(cornerRadius: 25)
                            .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius:10)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .offset(x: offset.width * 4.0)
        .rotationEffect(.degrees(offset.width / 5.0))
        .opacity(2 - (abs(offset.width / 50.0)))
        .accessibilityAddTraits(.isButton)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    offset = value.translation
                })
                .onEnded({ _ in
                    if abs(offset.width) > 100 {
                        removalCallable?() //OJO: Calls the funcion if there is one and does nothing if there is none
                    } else {
                        offset = CGSize.zero
                    }
                })
        )
        .animation(.spring, value: offset)
    }
}

#Preview {
    CardView(card: Card.example)
}
