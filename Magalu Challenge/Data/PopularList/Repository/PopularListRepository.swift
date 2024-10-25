//
//  PopularRepositoriesRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

class PopularListRepository : PopularListRepositoryProtocol {
    
    var dataSource : PopularListDataSourceProtocol
    
    init(dataSource: PopularListDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func doRequestGetPopularList(page: Int, completion: @escaping (Result<[RepositoryEntity], NetworkError>) -> Void) {
        self.dataSource.doRequestGetPopularList(page: page) { result in
            switch result {
            case .success(let success):
                completion(.success(RepositoryEntity.mapRepositoryResponseToRepositoryEntity(input: success ?? [])))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
