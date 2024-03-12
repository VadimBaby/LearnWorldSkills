//
//  HapticManagerView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 03.02.2024.
//

import SwiftUI

final class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticManagerView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Success") {
                HapticManager.instance.notification(type: .success)
            }
            Button("Warning") {
                HapticManager.instance.notification(type: .warning)
            }
            Button("Error") {
                HapticManager.instance.notification(type: .error)
            }
            Button("Soft") {
                HapticManager.instance.impact(style: .soft)
            }
            Button("Meduim") {
                HapticManager.instance.impact(style: .medium)
            }
            Button("Heavy") {
                HapticManager.instance.impact(style: .heavy)
            }
        }
    }
}

#Preview {
    HapticManagerView()
}
