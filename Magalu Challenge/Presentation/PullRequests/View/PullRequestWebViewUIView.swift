//
//  PullRequestWebViewUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import SwiftUI
import WebKit

struct PullRequestWebViewUIView: UIViewRepresentable {
    
    @StateObject var viewModel: WebViewViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.viewModel.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel)
    }
}
