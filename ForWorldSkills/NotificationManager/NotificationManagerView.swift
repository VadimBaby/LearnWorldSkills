//
//  NotificationManagerView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 02.02.2024.
//

import SwiftUI
import UserNotifications

final class NotificationManager {
    static let instance = NotificationManager()
    
    private let notificationManager: UNUserNotificationCenter = .current()
    
    func sendNotification() {
        let content: UNMutableNotificationContent = .init()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        notificationManager.add(request)
    }
    
    func requestAuthorization() {
        self.notificationManager.getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                self.notificationManager.requestAuthorization(options: [.sound, .badge, .alert]) { result, error in
                    print(result.description)
                }
            }
        }
    }
}

struct NotificationManagerView: View {
    var body: some View {
        Button("Send Notification") {
            NotificationManager.instance.sendNotification()
        }
        .onAppear {
            NotificationManager.instance.requestAuthorization()
        }
    }
}

#Preview {
    NotificationManagerView()
}
