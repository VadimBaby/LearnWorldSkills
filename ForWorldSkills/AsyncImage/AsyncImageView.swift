//
//  AsyncImageView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 31.01.2024.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
        VStack {
            AsyncImage(url: .init(string: "https://images.unsplash.com/photo-1674496969301-07ed9a0b18eb?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=150&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY5NDc5MTIyNw&ixlib=rb-4.0.3&q=80&w=500")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 100)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    AsyncImageView()
}
