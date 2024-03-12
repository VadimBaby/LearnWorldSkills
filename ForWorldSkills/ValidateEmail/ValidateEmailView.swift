//
//  ValidateEmailView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 30.01.2024.
//

import SwiftUI

struct ValidateEmailView: View {
    var body: some View {
        VStack {
           // Text(equal.description)
            Text(validateEmail("example@mail.com").description)
        }
    }
    
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-z0-9]+@[a-z0-9]+\.{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: emailRegex)
    }
}

#Preview {
    ValidateEmailView()
}

extension ValidateEmailView {
    var right: String {
        return #"^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$"#
    }
}
