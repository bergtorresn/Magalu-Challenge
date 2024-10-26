//
//  PopularRepositoriesRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import RxSwift

class PopularListRepository : PopularListRepositoryProtocol {
    
    var dataSource : PopularListDataSourceProtocol
    
    init(dataSource: PopularListDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func doRequestGetPopularList(page: Int) -> Single<[RepositoryEntity]> {
        return self.dataSource.doRequestGetPopularList(page: page).map { repository in
            return RepositoryEntity.mapRepositoryResponseToRepositoryEntity(input: repository.items)
        }
    }
}
