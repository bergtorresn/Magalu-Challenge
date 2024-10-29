//
//  PullRequestEntity.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation

struct PullRequestEntity: Identifiable, Equatable {
    
    var id: Int
    var title: String
    var body: String
    var url: String
    var createdAt: String
    var user: PullRequestUserEntity
    
    init(id: Int,
         title: String,
         body: String,
         url: String,
         createdAt: String,
         user: PullRequestUserEntity) {
        self.id = id
        self.title = title
        self.body = body
        self.url = url
        self.createdAt = createdAt
        self.user = user
    }
    
    static func toEntity(input response: [PullRequestModel]) -> [PullRequestEntity] {
        return response.map { result in
            return PullRequestEntity(id: result.id,
                                     title: result.title,
                                     body: result.body,
                                     url: result.url,
                                     createdAt: result.createdAt,
                                     user: PullRequestUserEntity.toEntity(input: result.user))
        }
    }
    
    static func == (lhs: PullRequestEntity, rhs: PullRequestEntity) -> Bool {
        return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.body == rhs.body
        && lhs.url == rhs.url
        && lhs.createdAt == rhs.createdAt
        && lhs.user == rhs.user
    }
}
