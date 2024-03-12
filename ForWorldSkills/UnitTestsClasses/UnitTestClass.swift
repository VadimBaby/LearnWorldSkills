//
//  UnitTestClass.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 04.02.2024.
//

import Foundation

final class UnitTestClass {
    @Published var strings: [String] = []
    
    func addString(string: String) {
        self.strings.append(string)
    }
    
    func removeString(string: String) {
        self.strings = strings.filter { $0 != string }
    }
}
