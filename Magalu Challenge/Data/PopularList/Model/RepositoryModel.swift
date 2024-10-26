//
//  RepositoryModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct RepositoryModel : Codable {
    
    var name: String = ""
    var fullName: String = ""
    var description: String = ""
    var stargazersCount: Int = 0
    var watchersCount: Int = 0
    var owner: OwnerModel = OwnerModel(name: "", avatar: "")
    
    init(name: String, 
         fullName: String,
         description: String,
         stargazersCount: Int,
         watchersCount: Int,
         owner: OwnerModel) {
        self.name = name
        self.fullName = fullName
        self.description = description
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.owner = owner
    }
    
    enum CodingKeys: String, CodingKey {
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case fullName = "full_name"
        case name, description, owner
    }
}
