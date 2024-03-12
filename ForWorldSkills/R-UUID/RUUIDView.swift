//
//  RUUIDView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 02.02.2024.
//

import SwiftUI

struct RUUIDView: View {
    var body: some View {
        Text(UUID().returnTrack())
    }
}

extension UUID {
    func returnTrack() -> String {
        let uuid = self.uuid
        
        let formattedString = String(format: "%02X%02X-%02X%02X-%02X%02X-%02X%02X", uuid.0, uuid.1, uuid.2, uuid.3, uuid.4, uuid.5, uuid.6, uuid.7, uuid.8, uuid.9, uuid.10, uuid.11, uuid.12, uuid.13, uuid.14, uuid.15)

        
        return "R-\(formattedString)"
    }
}

#Preview {
    RUUIDView()
}
