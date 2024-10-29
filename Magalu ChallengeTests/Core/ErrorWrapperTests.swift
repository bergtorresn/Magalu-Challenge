//
//  ErrorWrapperTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 29/10/24.
//

import XCTest

final class ErrorWrapperTests: XCTestCase {

    func testInit() {
           let message = "Error message"
           let errorWrapper = ErrorWrapper(message: message)
           XCTAssertEqual(errorWrapper.message, "Error message")
       }
       
       func testErrorWrapperUniqueID() {
           let errorWrapper1 = ErrorWrapper(message: "Error 1")
           let errorWrapper2 = ErrorWrapper(message: "Error 2")
           XCTAssertNotEqual(errorWrapper1.id, errorWrapper2.id)
       }

}
