//
//  SedamApp.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI
import Supabase

@main
struct SedamApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showUpdatePopUp: Bool = false
    
    init() {
        print("▶️ SUPABASE_KEY in bundle:", Bundle.main.supabaseKey ?? "Not Found")
        print("▶️ full InfoDictionary:", Bundle.main.infoDictionary ?? [:])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    isNeedUpdate()
                }
                .overlay {
                    if showUpdatePopUp {
                        CustomPopUpView(
                            showPopUp: $showUpdatePopUp,
                            title: "새로운 버전!",
                            message: "업데이트 가능한 버전이 있습니다.\n\n업데이트 하시겠습니까?",
                            leftButtonText: "취소",
                            rightButtonText: "확인",
                            leftButtonAction: { withAnimation { showUpdatePopUp = false }},
                            rightButtonAction: {
                                goUpdate()
                                showUpdatePopUp = false
                            }
                        )
                    }
                }
        }
    }
    
    func getAppStoreVersion() async -> String? {
        guard var components = URLComponents(string: "https://itunes.apple.com/lookup") else { return nil }
        components.queryItems = [
            URLQueryItem(name: "id",      value: "6745014813"), // 숫자 ID
            URLQueryItem(name: "country", value: "kr")
        ]
        guard let url = components.url else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let lookup = try decoder.decode(LookupResponse.self, from: data)
            return lookup.results.first?.version
        } catch {
            print("❌ 오류 발생:", error)
            return nil
        }
    }
    
    func getLocalAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    func isNeedUpdate() {
        Task {
            if let version = await getAppStoreVersion() {
                if version == getLocalAppVersion() {
                    showUpdatePopUp = false
                } else {
                    showUpdatePopUp = true
                }
            }
        }
    }
    
    func goUpdate() {
        let url = "itms-apps://itunes.apple.com/app/6745014813"
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
