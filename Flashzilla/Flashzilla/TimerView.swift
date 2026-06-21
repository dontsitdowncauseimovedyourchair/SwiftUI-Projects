//
//  TimerView.swift
//  Flashzilla
//
//  Created by Alejandro González on 21/06/26.
//

import Combine
import SwiftUI

struct TimerView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var count = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { time in
                if count == 5 {
                    cancelTImer()
                } else {
                    print("Time is now \(time)")
                }
                count += 1
            }
    }
    
    func cancelTImer() {
        timer.upstream.connect().cancel()
    }
    
}

#Preview {
    TimerView()
}
