//
//  RepositoryEntity.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct RepositoryEntity{
    var name: String
    var fullName: String
    var description: String
    var stargazersCount: Int
    var watchersCount: Int
    var owner: OwnerEntity
    
    init(name: String, fullName: String, description: String, stargazersCount: Int, watchersCount: Int, owner: OwnerEntity) {
        self.name = name
        self.fullName = fullName
        self.description = description
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.owner = owner
    }
    
    static func mapRepositoryResponseToRepositoryEntity(input response: [RepositoryResponse]) -> [RepositoryEntity] {
        return response.map { result in
            return RepositoryEntity(name: result.name,
                                    fullName: result.fullName,
                                    description: result.description,
                                    stargazersCount: result.stargazersCount,
                                    watchersCount: result.watchersCount,
                                    owner: OwnerEntity.mapOwnerModelToOwnerEntity(input: result.owner))
        }
    }
    
}
