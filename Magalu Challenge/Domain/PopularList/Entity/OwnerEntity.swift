//
//  OwnerEntity.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct OwnerEntity: Equatable {
    
    var name: String
    var avatar: String
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
    static func toOwnerEntity(input response: OwnerModel) -> OwnerEntity {
        return OwnerEntity(name: response.name, avatar: response.avatar)
    }
}
