//
//  RepositoryEntity.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct RepositoryEntity : Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var stargazersCount: Int
    var watchersCount: Int
    var owner: OwnerEntity
    
    init(name: String, description: String, stargazersCount: Int, watchersCount: Int, owner: OwnerEntity) {
        self.name = name
        self.description = description
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.owner = owner
    }
    
    static func toRepositoryEntity(input response: [RepositoryModel]) -> [RepositoryEntity] {
        return response.map { result in
            return RepositoryEntity(name: result.name,
                                    description: result.description,
                                    stargazersCount: result.stargazersCount,
                                    watchersCount: result.watchersCount,
                                    owner: OwnerEntity.toOwnerEntity(input: result.owner))
        }
    }
    
}
