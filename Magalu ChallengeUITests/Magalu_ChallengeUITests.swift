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

        // Verifique se a primeira tela está carregada
         XCTAssertTrue(app.staticTexts[AppStrings.navigationTitle].exists)
        }
}
