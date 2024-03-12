//
//  CustomFontView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 03.02.2024.
//

import SwiftUI

struct CustomFontView: View {
    var body: some View {
        Text("Hello, World! It's me")
            .customFont(size: 25)
    }
}

extension View {
    func customFont(size: CGFloat) -> some View {
        self
            .font(.custom("Waltograph UI Bold", size: size))
    }
}

#Preview {
    CustomFontView()
}
