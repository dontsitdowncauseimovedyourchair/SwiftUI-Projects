//
//  ContentView.swift
//  MultiFlop
//
//  Created by Alejandro González on 04/01/26.
//
import Observation
import SwiftUI

struct TextStyle : ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: size).weight(.heavy))
            .foregroundStyle(.white)
            .shadow(radius: 1, x: 1, y: 1)
    }
}

extension View {
    func styledText(size: CGFloat) -> some View {
        modifier(TextStyle(size: size))
    }
}

enum ButtonShape {
    case circle
    case capsule
}

struct ContentView: View {
    let bgCombinations: [(primary: Color, secondary: Color)] = [(.orange, .yellow), (.blue, .white), (.red, .orange), (.pink, .blue), (.blue, .orange)]
    
    @State private var currentColors = (primary: Color.orange, secondary: Color.yellow)
    
    @State private var selectedTable = 2
    @State private var numberOfQuestions = 10
    
    @State private var gameStarted = false
    @State private var gameShowingResults = false
    
    @State private var gameQuestionsArray: [Int] = []
    
    @State private var gameQuestion = 1
    @State private var gameScore = 0
    @State private var userAnswer = ""
    
    @FocusState private var answerFieldFocused: Bool
    
    @ViewBuilder
    func GameButton(_ text: String, shape: ButtonShape = .circle, textSize: CGFloat = 18, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
        }
        .frame(width: 80, height: 80)
        .background(currentColors.secondary)
        .styledText(size: textSize)
        .shadow(radius: 3, x: 1, y: 1)
        .clipShape(
            shape == .capsule ? AnyShape(Capsule()) : AnyShape(Circle())
        )
        .overlay {
            if shape == .capsule {
                Capsule()
                    .strokeBorder(currentColors.primary, lineWidth: 2)
            } else {
                Circle()
                    .strokeBorder(currentColors.primary, lineWidth: 2)
            }
        }
    }
    
    @ViewBuilder
    func SelectorButton(_ image: String, content: @escaping () -> Void) -> some View {
        Button() {
            content()
        } label: {
            Image(systemName: image)
                .font(.title)
                .foregroundStyle(.white)
                .frame(width: 100, height: 100)
                .background(currentColors.primary)
                .clipShape(.circle)
                .animation(.default, value: selectedTable)
        }
    }
    
    var body: some View {
        if (!gameStarted) {
            ZStack {
                LinearGradient(colors: [currentColors.primary, currentColors.secondary], startPoint: .top, endPoint: .bottom)
                
                VStack(spacing: 30) {
                    
                    Spacer()
                    
                    Text("Select the Table")
                        .styledText(size: 30)
                    
                    Spacer()
                    
                    HStack {
                        SelectorButton("chevron.left") {
                            selectedTable -= 1
                            if (selectedTable < 2) {
                                selectedTable = 2
                            }
                        }
                        
                        
                        Text("\(selectedTable)")
                            .frame(width: 150, height: 150)
                            .background(currentColors.primary)
                            .clipShape(.circle)
                            .styledText(size: 70)
                        
                        
                        SelectorButton("chevron.right") {
                            selectedTable += 1
                            if (selectedTable > 20) {
                                selectedTable = 20
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Stepper("\(numberOfQuestions) Questions", value: $numberOfQuestions, in: 5...20, step: 5)
                        .background(currentColors.primary)
                        .clipShape(.capsule)
                        .padding(.horizontal)
                        .styledText(size: 25)
                    
                    GameButton("Start") {
                        setupGame()
                            withAnimation {
                                gameStarted = true
                            }
                    }
                    
                    Spacer()
                }
            }
            .onChange(of: selectedTable) {
                    changeBGColor()
            }
            .ignoresSafeArea()
            .transition(.move(edge: .top))
        } else {
            ZStack {
                LinearGradient(colors: [currentColors.primary, currentColors.secondary], startPoint: .top, endPoint: .bottom)
                
                VStack {
                    Spacer()
                    
                    Text("Question \(gameQuestion)")
                        .styledText(size: 30)
                    
                    Text("Score: \(gameScore)")
                        .styledText(size: 20)

                    
                    Spacer()
                    
                    Text("\(selectedTable) x \(gameQuestionsArray[gameQuestion - 1])")
                        .styledText(size: 60)
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        TextField("Answer", text: $userAnswer)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .containerRelativeFrame(.horizontal) { length, axis in
                                length * 0.65
                            }
                            .padding()
                            .foregroundStyle(currentColors.primary)
                            .styledText(size: 20)
                            .textFieldStyle(.roundedBorder)
                            .focused($answerFieldFocused)
                        
                        GameButton("OK") {
                            checkAnswer()
                        }
                    }
                    
                    Spacer()
                    
                    Spacer()
                    
                    Spacer()
                }
                
                if gameShowingResults {
                    VStack {
                        Spacer()
                        Text("Game over")
                            .styledText(size: 40)
                        Text("Your score was \(gameScore)")
                            .styledText(size: 25)
                        Spacer()
                        Text("Play Again?")
                            .styledText(size: 20)
                        Spacer()
                        Button("Play Again") {
                            playAgain()
                        }
                        .styledText(size: 15)
                        .padding()
                        .background(currentColors.primary)
                        .clipShape(.capsule)
                        .overlay {
                            Capsule()
                                .stroke(currentColors.secondary)
                                .fill(.clear)
                        }
                        
                        Spacer()
                    }
                    .frame(width: 350, height: 250)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .transition(.scale)
                }
            }
            .ignoresSafeArea()
        }
    }
    
    func changeBGColor() {
        var newColors: (primary: Color, secondary: Color)
        repeat {
            newColors = bgCombinations.randomElement() ?? (primary: .orange, secondary: .yellow)
        } while(newColors == currentColors)
        
        withAnimation {
            currentColors = newColors
        }
    }
    
    func setupGame() {
        gameQuestionsArray.removeAll()
        
        for _ in 0..<numberOfQuestions {
            gameQuestionsArray.append(Int.random(in: 0...50))
        }
        gameScore = 0
        gameQuestion = 1
        userAnswer = ""
        withAnimation {
            gameShowingResults = false
        }
    }
    
    func checkAnswer() {
        if (Int(userAnswer) == (selectedTable * gameQuestionsArray[gameQuestion - 1])) {
                gameScore += 1
        }
        
        if gameQuestion == numberOfQuestions {
            endGame()
        } else {
            gameQuestion += 1
            userAnswer = ""
        }
    }
    
    func endGame() {
        answerFieldFocused = false
        withAnimation {
            gameShowingResults = true
        }
    }
    
    func playAgain() {
        withAnimation {
            gameShowingResults = false
            gameStarted = false
        }
    }
}

#Preview {
    ContentView()
}
