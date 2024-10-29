//
//  PullRequestUserModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest

final class PullRequestUserModelTests: XCTestCase {

    func testInit() {
        let model = PullRequestUserModel(name: "jaredsburrows",
                                      avatar: "https://avatars.githubusercontent.com/u/1739848?v=4")
        
        XCTAssertEqual(model.name, "jaredsburrows")
        XCTAssertEqual(model.avatar, "https://avatars.githubusercontent.com/u/1739848?v=4")
    }
    
    func testDecoding() {
        let json = """
         {
            "login": "jaredsburrows",
            "avatar_url": "https://avatars.githubusercontent.com/u/1739848?v=4",
          }
    """.data(using: .utf8)!
        
        do {
            let model = try JSONDecoder().decode(PullRequestUserModel.self, from: json)
            XCTAssertEqual(model.name, "jaredsburrows")
            XCTAssertEqual(model.avatar, "https://avatars.githubusercontent.com/u/1739848?v=4")
            
        } catch {
            XCTFail("Decoding failed with error \(error)")
        }
    }

}
