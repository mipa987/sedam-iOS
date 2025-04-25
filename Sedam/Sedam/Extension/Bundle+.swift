//
//  Bundle+.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import Foundation

extension Bundle {
    var supabaseKey: String? {
        object(forInfoDictionaryKey: "SUPABASE_KEY") as? String
    }
}
