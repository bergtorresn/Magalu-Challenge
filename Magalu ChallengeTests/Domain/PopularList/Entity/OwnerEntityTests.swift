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
    
    func testEntityEqualityShouldBeEqual() {
        
        let owner1 = OwnerEntity(name: "JetBrains",
                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        

        let owner2 = OwnerEntity(name: "JetBrains",
                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        XCTAssertEqual(owner1, owner2, "The instances should be equals")
    }
    
    func testEntityEqualityShouldNotBeEqual() {
        
        let owner1 = OwnerEntity(name: "JetBrains",
                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
    
        let owner2 = OwnerEntity(name: "bannedbook",
                                avatar: "https://avatars.githubusercontent.com/u/4361923?v=4")
        
        XCTAssertNotEqual(owner1, owner2, "The instances should be not equals")
    }
}
