//
//  LearnTimerView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 30.01.2024.
//

import SwiftUI

struct LearnTimerView: View {
    
    @State private var count: Int = 10
    @State private var timer = Timer.publish(every: 1.0, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        VStack {
            Text("\(count)")
            
            Button("start timer") {
                startTimer()
            }
        }
        .onAppear {
            stopTimer()
        }
        .onReceive(timer, perform: { _ in
            count -= 1
            
            if count <= 0 {
                stopTimer()
            }
        })
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
    }
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
    }
}

#Preview {
    LearnTimerView()
}
