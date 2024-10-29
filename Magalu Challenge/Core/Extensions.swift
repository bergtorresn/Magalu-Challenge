//
//  Extensions.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import SwiftUI
import WebKit

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}

extension Array where Element: Equatable {
    mutating func appendIfNotContains(_ newElement: Element) {
        if !self.contains(newElement) {
            self.append(newElement)
        }
    }
}

extension PullRequestWebViewUIView {
    class Coordinator: NSObject, WKNavigationDelegate {
        @ObservedObject private var webViewViewModel: WebViewViewModel
        private let parent: PullRequestWebViewUIView

        init(_ parent: PullRequestWebViewUIView, _ webViewModel: WebViewViewModel) {
            self.parent = parent
            self.webViewViewModel = webViewModel
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webViewViewModel.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webViewViewModel.isLoading = false
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            webViewViewModel.isLoading = false
        }
    }
}
