//
//  PopularListModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest

final class PopularListModelTests: XCTestCase {
    
    func testPopularListtInit() {
        let repository1 = RepositoryModel(name: "kotlin",
                                          description: "The Kotlin Programming Language.",
                                          stargazersCount: 49210,
                                          watchersCount: 49210,
                                          owner: OwnerModel(name: "JetBrains",
                                                            avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        
        let repository2 = RepositoryModel(name: "kotlin",
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
