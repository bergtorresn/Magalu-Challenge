//
//  ListRepositoryModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

struct PopularListModel: Codable {
    
    var items: [RepositoryModel] = []
    
    init(items: [RepositoryModel]) {
        self.items = items
    }
}
