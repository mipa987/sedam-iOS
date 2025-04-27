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
    @StateObject private var router = Router()
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        print("▶️ SUPABASE_KEY in bundle:",
              Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as Any)
        print("▶️ full InfoDictionary:", Bundle.main.infoDictionary ?? [:])
    }
    
    var body: some Scene {
        WindowGroup {
            let authViewModel = AuthViewModel()
            
            RouterView() {
                LoginView()
            }
            .environmentObject(authViewModel)
            .environmentObject(router)
                
        }
    }
}
