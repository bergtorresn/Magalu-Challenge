//
//  PullRequestWebViewUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import SwiftUI
import WebKit

struct PullRequestWebViewUIView: UIViewRepresentable {
    
    let repositoryURL: String
    
    init(repositoryURL: String) {
        self.repositoryURL = repositoryURL
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let urlRequest = URLRequest(url: URL(string: repositoryURL)!)
        uiView.load(urlRequest)
    }
}
