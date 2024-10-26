//
//  OwnerEntity.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct OwnerEntity {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func mapOwnerModelToOwnerEntity(input response: OwnerModel) -> OwnerEntity {
        return OwnerEntity(name: response.name)
    }

}
