//
//  WKWebViewPresentation.swift
//  세담
//
//  Created by minsong kim on 5/2/25.
//

import SwiftUI
import WebKit

struct WKWebViewPresentation: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else {
            return
        }
        
        uiView.load(URLRequest(url: url))
    }
}
