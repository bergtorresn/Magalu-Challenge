//
//  PopularListModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class PopularListModelTests: XCTestCase {
    
    func testInit() {
        let repository1 = RepositoryModel(id: 1,
                                          name: "kotlin",
                                          description: "The Kotlin Programming Language.",
                                          stargazersCount: 49210,
                                          watchersCount: 49210,
                                          owner: OwnerModel(name: "JetBrains",
                                                            avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        
        let repository2 = RepositoryModel(id: 1,
                                          name: "kotlin",
                                          description: "The Kotlin Programming Language.",
                                          stargazersCount: 49210,
                                          watchersCount: 49210,
                                          owner: OwnerModel(name: "JetBrains",
                                                            avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        
        let popularList = PopularListModel(items: [repository1, repository2])
        
        XCTAssertEqual(popularList.items.count, 2)
    }
    
    func testDecoding() {
        let json = """
            {
               "items":[
                  {
                     "id": 1,
                     "name":"kotlin",
                     "owner":{
                        "login":"JetBrains",
                        "avatar_url":"https://avatars.githubusercontent.com/u/878437?v=4"
                     },
                     "description":"The Kotlin Programming Language.",
                     "stargazers_count":49210,
                     "watchers_count":49210
                  },
                  {
                     "id": 2,
                     "name":"kotlin",
                     "owner":{
                        "login":"JetBrains",
                        "avatar_url":"https://avatars.githubusercontent.com/u/878437?v=4"
                     },
                     "description":"The Kotlin Programming Language.",
                     "stargazers_count":49210,
                     "watchers_count":49210
                  }
               ]
            }
""".data(using: .utf8)!
        
        do {
            let data = try JSONDecoder().decode(PopularListModel.self, from: json)
            XCTAssertEqual(data.items.count, 2)
            
        } catch {
            XCTFail("Decoding failed with error \(error)")
        }
    }
}
