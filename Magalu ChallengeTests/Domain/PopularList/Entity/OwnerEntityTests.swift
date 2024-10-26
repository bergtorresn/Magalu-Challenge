//
//  OwnerEntityTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class OwnerEntityTests: XCTestCase {

    func testOwnerInit() {
        let onwer = OwnerEntity(name: "JetBrains",
                                      avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        XCTAssertEqual(onwer.name, "JetBrains")
        XCTAssertEqual(onwer.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
    }
    
    func testModelToEntityConversion() {
        let ownerModel = OwnerModel(name: "JetBrains",
                         avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        let ownerEntity = OwnerEntity.toOwnerEntity(input: ownerModel)
        
        XCTAssertEqual(ownerModel.name, ownerEntity.name)
        XCTAssertEqual(ownerModel.avatar, ownerEntity.avatar)
    }
}
