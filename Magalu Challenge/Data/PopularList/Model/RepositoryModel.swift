//
//  RepositoryModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

class RepositoryModel : Codable {
    
    var id: Int = 1
    var name: String = ""
    var description: String = ""
    var stargazersCount: Int = 0
    var watchersCount: Int = 0
    var owner: OwnerModel = OwnerModel(name: "", avatar: "")
    
    init(id: Int,
         name: String,
         description: String,
         stargazersCount: Int,
         watchersCount: Int,
         owner: OwnerModel) {
        self.id = id
        self.name = name
        self.description = description
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.owner = owner
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
        self.watchersCount = try container.decode(Int.self, forKey: .watchersCount)
        self.owner =  try container.decode(OwnerModel.self, forKey: .owner)
    }
    
    enum CodingKeys: String, CodingKey {
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case name, description, owner, id
    }
}
