//
//  AppDelegate.swift
//  Sedam
//
//  Created by minsong kim on 5/30/25.
//

import SwiftUI

// NotificationManager가 delegate 역할을 하도록 AppDelegate 정의, 스케쥴 등록
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = NotificationManager.shared
        NotificationManager.shared.requestAuthorization()
        NotificationManager.shared.scheduleDailyNotification(
            id: "morningReminder",
            title: "굿모닝! ☀️",
            body: "오늘의 세 단어를 확인 후 글을 작성해볼까요?",
            hour: 8
        )
        NotificationManager.shared.scheduleDailyNotification(
            id: "eveningReminder",
            title: "굿이브닝! 🌙",
            body: "혹시 아직 글을 작성하지 않았다면, \n오늘의 세 단어를 확인 후 글을 작성해보세요!",
            hour: 20
        )
        return true
    }
}
