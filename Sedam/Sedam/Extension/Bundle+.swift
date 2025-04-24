//
//  Bundle+.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import Foundation

extension Bundle {
    var kakaoKey: String? {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let rawData = try? Data(contentsOf: URL(filePath: path)),
              let realData = try? PropertyListSerialization.propertyList(from: rawData, format: nil) as? [String: Any],
              let key = realData["KAKAO_KEY"] as? String else {
            return nil
        }
        
        return key
    }
    
    var supabaseKey: String? {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let rawData = try? Data(contentsOf: URL(filePath: path)),
              let realData = try? PropertyListSerialization.propertyList(from: rawData, format: nil) as? [String: Any],
              let key = realData["SUPABASE_KEY"] as? String else {
            return nil
        }
        
        return key
    }
}
