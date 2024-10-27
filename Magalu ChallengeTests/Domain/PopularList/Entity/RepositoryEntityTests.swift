//
//  RepositoryEntityTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class RepositoryEntityTests: XCTestCase {
    
    func testRepositoryInit() {
        let repository = RepositoryEntity(id: 1,
                                          name: "kotlin",
                                          description: "The Kotlin Programming Language.",
                                          stargazersCount: 49210,
                                          watchersCount: 49210,
                                          owner: OwnerEntity(name: "JetBrains",
                                                             avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        
        XCTAssertEqual(repository.name, "kotlin")
        XCTAssertEqual(repository.description, "The Kotlin Programming Language.")
        XCTAssertEqual(repository.stargazersCount, 49210)
        XCTAssertEqual(repository.watchersCount, 49210)
        XCTAssertEqual(repository.owner.name, "JetBrains")
        XCTAssertEqual(repository.owner.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
    }
    
    func testModelToEntityConversion() {
        
        let repositoryModel1 = RepositoryModel(id: 1,
                                               name: "kotlin",
                                               description: "Square’s meticulous HTTP client for the JVM, Android, and GraalVM.",
                                               stargazersCount: 49210,
                                               watchersCount: 49210,
                                               owner: OwnerModel(name: "JetBrains",
                                                                 avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        let repositoryModel2 = RepositoryModel(id: 1,
                                               name: "okhttp",
                                               description: "The Kotlin Programming Language.",
                                               stargazersCount: 45831,
                                               watchersCount: 45831,
                                               owner: OwnerModel(name: "square",
                                                                 avatar: "https://avatars.githubusercontent.com/u/82592?v=4"))
        
        
        let repositoryModelList = [repositoryModel1, repositoryModel2]
        
        let repositoryEntitylList = RepositoryEntity.toRepositoryEntity(input: repositoryModelList)
        
        
        XCTAssertEqual(repositoryEntitylList.count, repositoryModelList.count)
        
        for i in 0..<repositoryEntitylList.count {
            let model = repositoryModelList[i]
            let entity = repositoryEntitylList[i]
            
            XCTAssertEqual(model.name, entity.name)
            XCTAssertEqual(model.description, entity.description)
            XCTAssertEqual(model.stargazersCount, entity.stargazersCount)
            XCTAssertEqual(model.watchersCount, entity.watchersCount)
            
            XCTAssertEqual(model.owner.name, entity.owner.name)
            XCTAssertEqual(model.owner.avatar, entity.owner.avatar)
        }
    }
    
    func testEntityEqualityShouldBeEqual() {
        
        let owner = OwnerEntity(name: "JetBrains",
                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        let entity1 = RepositoryEntity(id: 1,
                                       name: "kotlin",
                                       description: "The Kotlin Programming Language.",
                                       stargazersCount: 49210,
                                       watchersCount: 49210,
                                       owner: owner)
        
        let entity2 = RepositoryEntity(id: 1,
                                       name: "kotlin",
                                       description: "The Kotlin Programming Language.",
                                       stargazersCount: 49210,
                                       watchersCount: 49210,
                                       owner: owner)
        
        
        XCTAssertEqual(entity1, entity2, "The instances should be equals")
    }
    
    func testEntityEqualityShouldNotBeEqual() {
        
        let owner = OwnerEntity(name: "JetBrains",
                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4")
        
        let entity1 = RepositoryEntity(id: 2,
                                       name: "okhttp",
                                       description: "The Kotlin Programming Language.",
                                       stargazersCount: 45831,
                                       watchersCount: 45831,
                                       owner: owner)
        
        let entity2 = RepositoryEntity(id: 1,
                                       name: "kotlin",
                                       description: "The Kotlin Programming Language.",
                                       stargazersCount: 49210,
                                       watchersCount: 49210,
                                       owner: owner)
        
        
        XCTAssertNotEqual(entity1, entity2, "The instances should be not equals")
    }
}
