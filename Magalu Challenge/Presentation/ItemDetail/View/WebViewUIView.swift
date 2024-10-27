//
//  WebViewUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import SwiftUI
import WebKit

struct WebViewUIView: View {
    let repositoryURL: String
    
    var body: some View {
        WebView(repositoryURL: repositoryURL)
    }
}

struct WebView: UIViewRepresentable {
    
    let webView: WKWebView
    let repositoryURL: String
    
    init(repositoryURL: String) {
        self.webView = WKWebView(frame: .zero)
        self.repositoryURL = repositoryURL
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: repositoryURL)!))
    }
}
