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
    @StateObject var authViewModel = AuthViewModel()
    @StateObject private var postViewModel = PostViewModel()
    
    init() {
        print("▶️ SUPABASE_KEY in bundle:", Bundle.main.supabaseKey ?? "Not Found")
        print("▶️ full InfoDictionary:", Bundle.main.infoDictionary ?? [:])
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
            .environmentObject(authViewModel)
            .environmentObject(postViewModel)
                
        }
    }
}
