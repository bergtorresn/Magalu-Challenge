//
//  WebViewViewModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 29/10/24.
//

import Foundation

class WebViewViewModel: ObservableObject {
    @Published var isLoading: Bool = false

    var url: String
    
    init(url: String) {
        self.url = url
    }
}
