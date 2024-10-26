//
//  OwnerEntityTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class OwnerEntityTests: XCTestCase {

    func testOwnerEntityInit() {
        let ownerEntity = OwnerEntity(name: "JetBrains",
                                      avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        XCTAssertEqual(ownerEntity.name, "JetBrains")
        XCTAssertEqual(ownerEntity.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
    }
    
    func testModelToEntityConversion() {
        let ownerModel = OwnerModel(name: "JetBrains",
                         avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        let ownerEntity = OwnerEntity.toOwnerEntity(input: ownerModel)
        
        XCTAssertEqual(ownerModel.name, ownerEntity.name)
        XCTAssertEqual(ownerModel.avatar, ownerEntity.avatar)
    }
}
