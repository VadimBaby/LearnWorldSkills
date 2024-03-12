//
//  AnimateProgressView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 11.02.2024.
//

import SwiftUI

struct AnimateProgressView: View {
    
    @State private var angle: Double = .zero
    @State private var success: Bool = false
    
    var body: some View {
        VStack {
            Group {
                if success {
                    Text("Success")
                } else {
                    Circle()
                        .stroke(
                            AngularGradient(colors: [Color.orange, Color.white], center: .center, angle: .degrees(angle))
                            , lineWidth: 25)
                        .frame(width: 150, height: 150)
                }
            }
            .frame(width: 150, height: 150)
        }
        .onAppear {
            withAnimation(.linear(duration: 3)) {
                self.angle = -4 * 360
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.success = true
            })
        }
    }
}

#Preview {
    AnimateProgressView()
        .padding()
}
