//
//  Magalu_ChallengeUITests.swift
//  Magalu ChallengeUITests
//
//  Created by Rosemberg Torres on 29/10/24.
//

import XCTest

final class Magalu_ChallengeUITests: XCTestCase {

    func testRepositoryListContainsSpecificItem() {
        let app = XCUIApplication()
        app.launch()
        
        let listItem = app.staticTexts["awesome-ios"]
        XCTAssertTrue(listItem.waitForExistence(timeout: 5))
        listItem.tap()
        
        let pullRequestView = app.staticTexts["Add Pagination"]
        XCTAssertTrue(pullRequestView.waitForExistence(timeout: 5))
    }
}
