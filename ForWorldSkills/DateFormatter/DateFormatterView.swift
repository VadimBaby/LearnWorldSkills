//
//  DateFormatterView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 07.03.2024.
//

import SwiftUI

struct DateFormatterView: View {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        
        return formatter
    }
    
    var body: some View {
        Text(dateFormatter.string(from: .init()))
    }
}

#Preview {
    DateFormatterView()
}
