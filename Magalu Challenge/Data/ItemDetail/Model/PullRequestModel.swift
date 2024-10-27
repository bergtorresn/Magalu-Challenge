//
//  PullRequestListModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation

class PullRequestModel: Codable {
    
    var id: Int
    var title: String
    var body: String
    var url: String
    var createdAt: String
    var user: PullRequestUserModel
    
    init(id: Int,
         title: String,
         body: String,
         url: String,
         createdAt: String,
         user: PullRequestUserModel) {
        self.id = id
        self.title = title
        self.body = body
        self.url = url
        self.createdAt = createdAt
        self.user = user
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.url = try container.decode(String.self, forKey: .url)
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        self.id = try container.decode(Int.self, forKey: .id)
        self.user = try container.decode(PullRequestUserModel.self, forKey: .user)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case url = "html_url"
        case body, id, user, title
    }
}
