//
//  WordModel.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 05.02.2024.
//

import Foundation
import SwiftData

@Model final class WordModel {
    let id: String = UUID().uuidString
    let word: String
    let translate: String
    
    init(word: String, translate: String) {
        self.word = word
        self.translate = translate
    }
}
