//
//  OwnerModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct OwnerModel: Codable {
    
    var name: String = ""
    var avatar: String = ""
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
    }
}
