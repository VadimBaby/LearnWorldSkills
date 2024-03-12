//
//  VisibleSecureFieldView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 30.01.2024.
//

import SwiftUI

struct VisibleSecureFieldView: View {
    @State private var password: String = ""

    var body: some View {
        VStack {
            SecureTextField(placeholder: "Placeholder", text: $password)
        }
        .padding()
    }
}

struct SecureTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.leading)
            .background(Color.gray.opacity(0.2))
            .clipShape(.rect(cornerRadius: 15))
            
            Button(action: {
                self.isSecure.toggle()
            }, label: {
                Image(systemName: isSecure ? "eye.slash" : "eye")
            })
            .tint(Color.black)
            .padding(.trailing)
        }
    }
}


#Preview {
    VisibleSecureFieldView()
}
