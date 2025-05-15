//
//  SupabaseManager.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    
    private init() {}
    
    let supabase: SupabaseClient = SupabaseClient(
        supabaseURL: URL(string: "https://vjicrnaakktpzutjudae.supabase.co")!,
        supabaseKey: Bundle.main.supabaseKey ?? ""
    )
}
