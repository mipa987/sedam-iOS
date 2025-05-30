//
//  NotificationManager.swift
//  Sedam
//
//  Created by minsong kim on 5/30/25.
//

import SwiftUI
import UserNotifications

final class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    private override init() {}
    
    // 1) 권한 요청
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("알림 권한 요청 에러:", error)
            } else {
                print("알림 권한:", granted ? "허용" : "거부")
            }
        }
    }
    
    // 2) 매일 같은 시각에 알림 스케줄링
    func scheduleDailyNotification(id: String,
                                   title: String,
                                   body: String,
                                   hour: Int,
                                   minute: Int = 0) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        // 날짜 구성 (매일 hour:minute)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter
            .current()
            .add(request) { error in
                if let error = error {
                    print("스케줄 등록 실패:", error)
                } else {
                    print("스케줄 등록 성공: \(id) @\(hour):\(minute)")
                }
            }
    }
}

// 푸시 도착 시 앱 포그라운드에서도 알림 표시하려면 delegate 구현
extension NotificationManager: UNUserNotificationCenterDelegate {
    // 앱 실행 중에도 배너/사운드를 띄우고 싶을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

