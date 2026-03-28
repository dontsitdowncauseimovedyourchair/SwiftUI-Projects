//
//  ContentView.swift
//  WorldScrambleApp
//
//  Created by Alejandro González on 28/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var allWords: [String] = []
    @State private var score = 0
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    } footer: {
                        Text("Score: \(score)")
                            .font(.callout)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    
                    if (usedWords.isEmpty) {
                        Text("Unscramble words from \(rootWord)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) { } message: {
                    Text(errorMessage)
                }
                .toolbar() {
                    Button("New Word") {
                        changeWord()
                    }
                }
            }
        }
    }
    
    func addNewWord() {
        let answer : String = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        newWord = ""
        
        guard isOriginal(word: answer) else {
            wordError(title: "Flop", message: "Answer does not impose novelty.")
            score -= 200
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Flop", message: "Answer not scrambable from \(rootWord).")
            score -= 200
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Flop", message: "Answer is not speaking English :(")
            score -= 100
            return
        }
        
        guard isCompetitive(word: answer) else {
            wordError(title: "Flop", message: "Answer is shorter than Yoda (at least 4 characters)")
            score -= 100
            return
        }
                
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += answer.count * 100
    }
    
    func startGame() {
        if let url = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let words = try? String(contentsOf: url, encoding: .ascii) {
                allWords = words.components(separatedBy: .newlines)
                rootWord = allWords.randomElement() ?? "silksong"
                return
            }
        }
        fatalError("Flopped whilst trying to load start.txt")
    }
    
    func randomWord() -> String {
        allWords.randomElement() ?? "silksong"
    }
    
    func changeWord() {
        rootWord = randomWord()
        score = 0
        newWord = ""
        withAnimation{
            usedWords.removeAll()
        }
    }
    
    func isOriginal(word: String) -> Bool {
        if (word == rootWord) { return false }
        return !usedWords.contains(word);
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false;
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isCompetitive(word: String) -> Bool {
        return word.count > 3
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
