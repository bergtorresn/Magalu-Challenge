//
//  PopularRepositoriesRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

class PopularRepositoriesRepository : PopularRepositoriesRepositoryProtocol {
    
    var dataSource : RepositoryListDataSourceProtocol
    
    init(dataSource: RepositoryListDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func doRequestGetPopularRepositories(page: Int, completion: @escaping (Result<[RepositoryResponse], NetworkError>) -> Void) {
        self.dataSource.doRequestGetPopularRepositories(page: page) { result in
            switch result {
            case .success(let success):
                completion(.success(success ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
