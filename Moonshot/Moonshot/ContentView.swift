//
//  ContentView.swift
//  Moonshot
//
//  Created by Alejandro González on 11/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isGridView: Bool = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            Group {
                if isGridView {
                    GridView
                } else {
                    ListView
                }
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    isGridView.toggle()
                } label: {
                    if isGridView {
                        Image(systemName: "square.grid.2x2")
                    } else {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
    }
    
    
    var GridView : some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.displayDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .background(.darkBackground)
        .navigationDestination(for: Mission.self) { mission in
            MissionView(mission: mission, astronauts: astronauts)
        }
    }
    
    var ListView : some View {
        ScrollView {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    VStack {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 120)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.displayDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.lightBackground)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.lightBackground, lineWidth: 1)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(.darkBackground)
        .navigationDestination(for: Mission.self) { mission in
            MissionView(mission: mission, astronauts: astronauts)
        }
    }
}

#Preview {
    ContentView()
}
