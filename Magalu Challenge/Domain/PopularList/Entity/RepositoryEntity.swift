//
//  RepositoryEntity.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct RepositoryEntity: Identifiable, Equatable {
    let id: Int
    var name: String
    var description: String
    var stargazersCount: Int
    var watchersCount: Int
    var owner: OwnerEntity
    
    init(id: Int, name: String, description: String, stargazersCount: Int, watchersCount: Int, owner: OwnerEntity) {
        self.id = id
        self.name = name
        self.description = description
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.owner = owner
    }
    
    static func toRepositoryEntity(input response: [RepositoryModel]) -> [RepositoryEntity] {
        return response.map { result in
            return RepositoryEntity(id: result.id,
                                    name: result.name,
                                    description: result.description,
                                    stargazersCount: result.stargazersCount,
                                    watchersCount: result.watchersCount,
                                    owner: OwnerEntity.toOwnerEntity(input: result.owner))
        }
    }
    
    static func == (lhs: RepositoryEntity, rhs: RepositoryEntity) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.description == rhs.description
        && lhs.stargazersCount == rhs.stargazersCount
        && lhs.watchersCount == rhs.watchersCount
        && lhs.owner == rhs.owner
    }
}
