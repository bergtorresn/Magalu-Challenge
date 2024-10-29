//
//  OwnerModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class OwnerModelTests: XCTestCase {
    
    func testInit() {
        let owner = OwnerModel(name: "JetBrains",
                                      avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        XCTAssertEqual(owner.name, "JetBrains")
        XCTAssertEqual(owner.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
    }
    
    func testDecoding() {
        let json = """
         {
            "login": "JetBrains",
            "avatar_url": "https://avatars.githubusercontent.com/u/878437?v=4",
          }
    """.data(using: .utf8)!
        
        do {
            let data = try JSONDecoder().decode(OwnerModel.self, from: json)
            XCTAssertEqual(data.name, "JetBrains")
            XCTAssertEqual(data.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
            
        } catch {
            XCTFail("Decoding failed with error \(error)")
        }
    }
}
