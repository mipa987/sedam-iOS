//
//  KeyChainModule.swift
//  Sedam
//
//  Created by minsong kim on 5/13/25.
//

import Foundation

final class KeyChainModule {
    enum Key: String {
        case accessToken
        case refreshToken
        case isLogin
        case guestMode
    }
    
    static func create(key: Key, data: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: data.data(using: .utf8) as Any
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            print("✅ keychain success")
        case errSecDuplicateItem:
            update(key: key, data: data)
        default:
            print("❌ keychain create failure")
        }
    }
    
    static func read(key: Key) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            guard let retrieveData = dataTypeRef as? Data else {
                return nil
            }
            let value = String(data: retrieveData, encoding: String.Encoding.utf8)
            return value
        } else {
            return nil
        }
    }
    
    static func update(key: Key, data: String) {
        let previousQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
        ]
        
        let updateQuery: [CFString: Any] = [
            kSecValueData: data.data(using: .utf8) as Any
        ]
        
        let status = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)
        
        switch status {
        case errSecSuccess:
            print("✅ keychain update success")
        default:
            print("❌ keychain update failure")
        }
    }
    
    static func delete(key: Key) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        assert(status == noErr, "❌ keychain delete failure")
    }
}
