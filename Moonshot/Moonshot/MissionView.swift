//
//  MissionView.swift
//  Moonshot
//
//  Created by Alejandro González on 17/01/26.
//

import SwiftUI


struct CrewMember : Hashable {
    let role: String
    let astronaut: Astronaut
}

struct HorizontalDivider : View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct CrewScroller : View {
    var crew: [CrewMember]
    var axis: Axis.Set = .horizontal
    
    var body: some View {
        ScrollView(axis == .horizontal ? .horizontal : .vertical) {
            Group {
                if (axis == .horizontal) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink(value: crewMember.astronaut) {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline.bold())
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.6))
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                } else {
                    VStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink(value: crewMember.astronaut) {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 110, height: 130)
                                        .clipShape(.capsule)
                                        .overlay {
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 2)
                                        }
                                    Spacer()
                                    VStack {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline.bold())
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.6))
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(.lightBackground)
                                .clipShape(.rect(cornerRadius: 10))
                                
                                
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationDestination(for: Astronaut.self) { astronaut in
                AstronautView(astronaut: astronaut)
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct MissionView : View {
    
    let mission: Mission
    let astronauts: [String: Astronaut]
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Text(mission.displayName)
                    .font(.title.bold())
                    .padding()
                
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axes in
                        width * 0.6
                    }
                    .padding(.top)
                
                
                VStack() {
                    Text("Launch Date")
                        .font(.title3.bold())
                    if (mission.launchDate != nil) {
                        Text(mission.displayDate)
                    } else {
                        Text("Did not Launch")
                    }
                }
                .padding(.top, 25)
                                
                VStack(alignment: .leading) {
                    HorizontalDivider()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding([.bottom], 5)
                    
                    Text(mission.description)
                    
                    HorizontalDivider()
                    
                    Text("Crew")
                        .font(.title.bold())
                }
                .padding(.horizontal)
                
                CrewScroller(crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String : Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Flop data, can't find \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
