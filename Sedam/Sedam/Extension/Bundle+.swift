//
//  Bundle+.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import Foundation

extension Bundle {
    var kakaoKey: String? {
        object(forInfoDictionaryKey: "KakaoKey") as? String
    }
    
    var supabaseKey: String? {
        object(forInfoDictionaryKey: "SupabaseKey") as? String
    }
}
