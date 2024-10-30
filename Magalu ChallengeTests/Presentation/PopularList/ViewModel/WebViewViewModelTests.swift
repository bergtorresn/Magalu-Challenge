//
//  WebViewViewModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 30/10/24.
//

import XCTest

final class WebViewViewModelTests: XCTestCase {

    func testInit() {
            let testURL = "https://google.com"
            let viewModel = WebViewViewModel(url: testURL)
            XCTAssertEqual(viewModel.url, testURL)
        }
        
        func testIsLoadingDefaultValue() {
            let viewModel = WebViewViewModel(url: "https://google.com")
            XCTAssertFalse(viewModel.isLoading)
        }
        
        func testIsLoadingChange() {
            let viewModel = WebViewViewModel(url: "https://google.com")
            viewModel.isLoading = true
            XCTAssertTrue(viewModel.isLoading)
            
            viewModel.isLoading = false
            
            XCTAssertFalse(viewModel.isLoading)
        }

}
