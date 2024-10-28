//
//  PullRequestEntityTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest

final class PullRequestEntityTests: XCTestCase {
    
    func testInit() {
        let entity = PullRequestEntity(id: 1,
                                            title: "Fix pymdownx.emoji extension warning",
                                            body: "## Description\r\n - Fix pymdownx.emoji",
                                            url: "https://github.com/square/okhttp/pull/8559",
                                            createdAt: "2024-10-19T18:23:17Z",
                                            user: PullRequestUserEntity(name: "jaredsburrows",
                                                                        avatar: "https://avatars.githubusercontent.com/u/1739848?v=4"))
        
        XCTAssertEqual(entity.id, 1)
        XCTAssertEqual(entity.title, "Fix pymdownx.emoji extension warning")
        XCTAssertEqual(entity.body, "## Description\r\n - Fix pymdownx.emoji")
        XCTAssertEqual(entity.url, "https://github.com/square/okhttp/pull/8559")
        XCTAssertEqual(entity.createdAt, "2024-10-19T18:23:17Z")
        XCTAssertEqual(entity.user.name, "jaredsburrows")
        XCTAssertEqual(entity.user.avatar, "https://avatars.githubusercontent.com/u/1739848?v=4")
    }
    
    func testModelToEntityConversion() {
        
        let model1 = PullRequestModel(id: 1,
                                      title: "Fix pymdownx.emoji extension warning",
                                      body: "## Description\r\n - Fix pymdownx.emoji",
                                      url: "https://github.com/square/okhttp/pull/8559",
                                      createdAt: "2024-10-19T18:23:17Z",
                                      user: PullRequestUserModel(name: "jaredsburrows",
                                                                 avatar: "https://avatars.githubusercontent.com/u/1739848?v=4"))
        let model2 = PullRequestModel(id: 2,
                                      title: "Add QUERY method support",
                                      body: "Fixes #8380.\r\n\r\nThis PR adds a new public method,",
                                      url: "https://github.com/square/okhttp/pull/8550",
                                      createdAt: "2024-10-08T21:49:48Z",
                                      user: PullRequestUserModel(name: "desiderantes",
                                                                 avatar: "https://avatars.githubusercontent.com/u/1703429?v=4"))
        
        
        let modelList = [model1, model2]
        
        let entitylList = PullRequestEntity.toEntity(input: modelList)
        
        
        XCTAssertEqual(entitylList.count, modelList.count)
        
        for i in 0..<entitylList.count {
            let model = modelList[i]
            let entity = entitylList[i]
            
            XCTAssertEqual(model.title, entity.title)
            XCTAssertEqual(model.body, entity.body)
            XCTAssertEqual(model.url, entity.url)
            XCTAssertEqual(model.createdAt, entity.createdAt)
            
            XCTAssertEqual(model.user.name, entity.user.name)
            XCTAssertEqual(model.user.avatar, entity.user.avatar)
        }
    }
    
    func testEntityEqualityShouldBeEqual() {
        
        let user = PullRequestUserEntity(name: "desiderantes",
                                         avatar: "https://avatars.githubusercontent.com/u/1703429?v=4")
        
        let entity1 = PullRequestEntity(id: 1,
                                        title: "Fix pymdownx.emoji extension warning",
                                        body: "## Description\r\n - Fix pymdownx.emoji",
                                        url: "https://github.com/square/okhttp/pull/8559",
                                        createdAt: "2024-10-19T18:23:17Z",
                                        user: user)
        let entity2 = PullRequestEntity(id: 1,
                                        title: "Fix pymdownx.emoji extension warning",
                                        body: "## Description\r\n - Fix pymdownx.emoji",
                                        url: "https://github.com/square/okhttp/pull/8559",
                                        createdAt: "2024-10-19T18:23:17Z",
                                        user: user)
        
        XCTAssertEqual(entity1, entity2)
    }
    
    func testEntityEqualityShouldNotBeEqual() {
        
        let user = PullRequestUserEntity(name: "desiderantes",
                                         avatar: "https://avatars.githubusercontent.com/u/1703429?v=4")
        
        let entity1 = PullRequestEntity(id: 1,
                                        title: "Fix pymdownx.emoji extension warning",
                                        body: "## Description\r\n - Fix pymdownx.emoji",
                                        url: "https://github.com/square/okhttp/pull/8559",
                                        createdAt: "2024-10-19T18:23:17Z",
                                        user: user)
        let entity2 = PullRequestEntity(id: 2,
                                        title: "Add QUERY method support",
                                        body: "Fixes #8380.\r\n\r\nThis PR adds a new public method,",
                                        url: "https://github.com/square/okhttp/pull/8550",
                                        createdAt: "2024-10-08T21:49:48Z",
                                        user: user)
        
        
        XCTAssertNotEqual(entity1, entity2)
    }
}
