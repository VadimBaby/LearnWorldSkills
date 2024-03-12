//
//  JustTest.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 13.02.2024.
//

import SwiftUI
import UIKit

enum Utils {
    static var size: CGSize {
        get {
            UIScreen.main.bounds.size
        }
    }
}

struct JustTest: View {
    @StateObject private var viewModel: Self.ViewModel = .init()
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        VStack {
            Text("\(viewModel.someshit)")
            Text("\(Utils.size.width)")
            Rectangle()
                .fill(Color.red)
                .frame(height: 150)
                .frame(maxWidth: Utils.size.width)
        }
        .onReceive(timer, perform: { _ in
            viewModel.add()
        })
    }
}

extension JustTest {
    final class ViewModel: ObservableObject {
        @Published var someshit: Int = 0
        
        func add() {
            someshit += 1
        }
    }
}

#Preview {
    JustTest()
}
