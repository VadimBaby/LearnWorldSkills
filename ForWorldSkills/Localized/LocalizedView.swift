//
//  LocalizedView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 03.02.2024.
//

import SwiftUI

struct LocalizedView: View {
    var body: some View {
        Text("hello-string")
    }
}

#Preview {
    LocalizedView()
        .environment(\.locale, .init(identifier: "ru"))
}
