//
//  AstronautView.swift
//  Moonshot
//
//  Created by Alejandro González on 17/01/26.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            Image(astronaut.id)
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            
            Text(astronaut.description)
                .padding(.horizontal)
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    AstronautView(astronaut: astronauts["grissom"]!)
        .preferredColorScheme(.dark)
}
