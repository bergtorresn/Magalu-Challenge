//
//  RepositoryEntityTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class RepositoryEntityTests: XCTestCase {
    
    func testEntityInit() {
        let repositoryEntity = RepositoryEntity(name: "kotlin",
                                              description: "The Kotlin Programming Language.",
                                              stargazersCount: 49210,
                                              watchersCount: 49210,
                                              owner: OwnerEntity(name: "JetBrains",
                                                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        
        XCTAssertEqual(repositoryEntity.name, "kotlin")
        XCTAssertEqual(repositoryEntity.description, "The Kotlin Programming Language.")
        XCTAssertEqual(repositoryEntity.stargazersCount, 49210)
        XCTAssertEqual(repositoryEntity.watchersCount, 49210)
        XCTAssertEqual(repositoryEntity.owner.name, "JetBrains")
        XCTAssertEqual(repositoryEntity.owner.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
    }
    
    func testModelToEntityConversion() {
        
        let repositoryModel1 = RepositoryModel(name: "kotlin",
                                              description: "Square’s meticulous HTTP client for the JVM, Android, and GraalVM.",
                                              stargazersCount: 49210,
                                              watchersCount: 49210,
                                              owner: OwnerModel(name: "JetBrains",
                                                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        let repositoryModel2 = RepositoryModel(name: "okhttp",
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
}
