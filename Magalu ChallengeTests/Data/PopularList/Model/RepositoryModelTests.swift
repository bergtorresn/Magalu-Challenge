//
//  RepositoryModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class RepositoryModelTests: XCTestCase {

    func testInit() {
        let repository = RepositoryModel(id: 1, name: "kotlin",
                                              description: "The Kotlin Programming Language.",
                                              stargazersCount: 49210,
                                              watchersCount: 49210,
                                              owner: OwnerModel(name: "JetBrains",
                                                                avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        
        XCTAssertEqual(repository.id, 1)
        XCTAssertEqual(repository.name, "kotlin")
        XCTAssertEqual(repository.description, "The Kotlin Programming Language.")
        XCTAssertEqual(repository.stargazersCount, 49210)
        XCTAssertEqual(repository.watchersCount, 49210)
        XCTAssertEqual(repository.owner.name, "JetBrains")
        XCTAssertEqual(repository.owner.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
    }
    
    func testDecodingWithCompleteJson() {
        let json = """
         {     "id": 1,
               "name": "kotlin",
               "owner": {
                 "login": "JetBrains",
                 "avatar_url": "https://avatars.githubusercontent.com/u/878437?v=4",
               },
               "description": "The Kotlin Programming Language.",
               "stargazers_count": 49210,
               "watchers_count": 49210,
    }
    """.data(using: .utf8)!
        
        do {
            let data = try JSONDecoder().decode(RepositoryModel.self, from: json)
            XCTAssertEqual(data.id, 1)
            XCTAssertEqual(data.name, "kotlin")
            XCTAssertEqual(data.description, "The Kotlin Programming Language.")
            XCTAssertEqual(data.stargazersCount, 49210)
            XCTAssertEqual(data.watchersCount, 49210)
            XCTAssertEqual(data.owner.name, "JetBrains")
            XCTAssertEqual(data.owner.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
        } catch {
            XCTFail("Decoding failed with error \(error)")
        }
    }
    
    func testDecodingWithoutDescriptionValue() {
        let json = """
         {     "id": 1,
               "name": "kotlin",
               "owner": {
                 "login": "JetBrains",
                 "avatar_url": "https://avatars.githubusercontent.com/u/878437?v=4",
               },
               "description": null,
               "stargazers_count": 49210,
               "watchers_count": 49210,
    }
    """.data(using: .utf8)!
        
        do {
            let data = try JSONDecoder().decode(RepositoryModel.self, from: json)
            XCTAssertEqual(data.id, 1)
            XCTAssertEqual(data.name, "kotlin")
            XCTAssertEqual(data.description, "")
            XCTAssertEqual(data.stargazersCount, 49210)
            XCTAssertEqual(data.watchersCount, 49210)
            XCTAssertEqual(data.owner.name, "JetBrains")
            XCTAssertEqual(data.owner.avatar, "https://avatars.githubusercontent.com/u/878437?v=4")
        } catch {
            XCTFail("Decoding failed with error \(error)")
        }
    }
}
