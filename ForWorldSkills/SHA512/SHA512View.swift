//
//  SHA512View.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 02.02.2024.
//

import SwiftUI
import CryptoKit

struct SHA512View: View {
    
    @State private var hashedPassowrd: String = ""
    @State private var password: String = "double'o"
    
    var body: some View {
        VStack {
            Text(hashedPassowrd)
            
            SecureTextField(placeholder: "Password", text: $password)
            
            Button("Save Password") {
                savePassword(password)
            }
        }
        .padding()
    }
    
    private func savePassword(_ password: String) {
        if let passwordData = password.data(using: .utf8) {
            let hashedPassword = SHA512.hash(data: passwordData)
            
            let hashedPasswordString = hashedPassword.compactMap {
                String(format: "%02x", $0)
            }.joined()
            
            print(hashedPasswordString)
        }
    }
    
//    private func savePassword(_ password: String) {
//        if let passwordData = password.data(using: .utf8) {
//            let hashedPassword = SHA512.hash(data: passwordData)
//            
//            let hashedPasswordString = hashedPassword.compactMap {
//                String(format: "%02x", $0)
//            }.joined()
//            
//            print(hashedPasswordString)
//        }
//    }
}

#Preview {
    SHA512View()
}
