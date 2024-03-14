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
            Text(isValidEmail("exDdfampl21e@ma2il.ca").description)
        }
    }
    
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-z0-9]+@[a-z0-9]+\.{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPredicate.evaluate(with: email)
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
