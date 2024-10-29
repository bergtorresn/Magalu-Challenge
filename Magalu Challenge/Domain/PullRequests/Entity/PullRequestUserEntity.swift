//
//  PullRequestUserEntity.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation

struct PullRequestUserEntity: Equatable {

    var name: String
    var avatar: String
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
    static func toEntity(input response: PullRequestUserModel) -> PullRequestUserEntity {
        return PullRequestUserEntity(name: response.name, avatar: response.avatar)
    }
}
