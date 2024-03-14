//
//  SwipeOnboardingView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 14.03.2024.
//

import SwiftUI

struct SwipeOnboardingView: View {
    let data = Array(1...10)

    var body: some View {
        TabView {
            ForEach(data, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text("\(index)")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.red.opacity(Double(index) / 10))
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}

#Preview {
    SwipeOnboardingView()
}
