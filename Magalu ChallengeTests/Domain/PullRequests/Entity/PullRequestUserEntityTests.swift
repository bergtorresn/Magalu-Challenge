//
//  PullRequestUserEntityTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest

final class PullRequestUserEntityTests: XCTestCase {
    
    func testOwnerInit() {
        
        let user = PullRequestUserEntity(name: "desiderantes",
                                         avatar: "https://avatars.githubusercontent.com/u/1703429?v=4")
        
        XCTAssertEqual(user.name, "desiderantes")
        XCTAssertEqual(user.avatar, "https://avatars.githubusercontent.com/u/1703429?v=4")
    }
    
    func testModelToEntityConversion() {
        let model = PullRequestUserModel(name: "desiderantes",
                                         avatar: "https://avatars.githubusercontent.com/u/1703429?v=4")
        
        let entity = PullRequestUserEntity.toEntity(input: model)
        
        XCTAssertEqual(model.name, entity.name)
        XCTAssertEqual(model.avatar, entity.avatar)
    }
    
    func testEntityEqualityShouldBeEqual() {
        
        let entity1 = PullRequestUserEntity(name: "desiderantes",
                                            avatar: "https://avatars.githubusercontent.com/u/1703429?v=4")
        
        let entity2 = PullRequestUserEntity(name: "desiderantes",
                                            avatar: "https://avatars.githubusercontent.com/u/1703429?v=4")
        
        XCTAssertEqual(entity1, entity2)
    }
    
    func testEntityEqualityShouldNotBeEqual() {
        
        let entity1 = PullRequestUserEntity(name: "desiderantes",
                                            avatar: "https://avatars.githubusercontent.com/u/1703429?v=4")
        
        let entity2 = PullRequestUserEntity(name: "jaredsburrows",
                                            avatar: "https://avatars.githubusercontent.com/u/1739848?v=4")
        
        XCTAssertNotEqual(entity1, entity2)
    }
}
