//
//  UserTermName.swift
//  세담
//
//  Created by 여성찬 on 5/4/25.
//
enum TermName {
    case privacyPolicy 
    
    var name: String {
        switch self {
        case .privacyPolicy:
            "sedam_privacy_policy"
        }
    }
}
