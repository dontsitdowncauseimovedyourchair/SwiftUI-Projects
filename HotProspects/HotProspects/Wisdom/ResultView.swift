//
//  ResultView.swift
//  HotProspects
//
//  Created by Alejandro González on 16/06/26.
//


import SwiftUI

struct ResultView : View {
    @State private var text = ""
    var body: some View {
        Text(text)
            .task {
                await fetchData()
            }
    }
    
    func fetchData() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let reading = try JSONDecoder().decode([Double].self, from: data)
            return "Readings were a whopping \(reading.count)"
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let string):
            text = string
        case .failure(let error):
            text = error.localizedDescription
        }
        
    }
}

#Preview {
    ResultView()
}
