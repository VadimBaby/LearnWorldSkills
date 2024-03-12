//
//  DictionaryModel.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 05.02.2024.
//

import Foundation
import SwiftData

@Model final class DictionaryModel {
    let id: String = UUID().uuidString
    var name: String
    let words: [WordModel]
    let createdAt: Date = Date.now
    
    init(name: String, words: [WordModel]) {
        self.name = name
        self.words = words
    }
}
