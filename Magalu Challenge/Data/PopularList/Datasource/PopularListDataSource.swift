//
//  RepositoryListDataSource.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

protocol RepositoryListDataSourceProtocol {
    func doRequestGetPopularList(page: Int, completion: @escaping (Result<[RepositoryResponse]?, NetworkError>) -> Void)
}

class RepositoryListDataSource: RepositoryListDataSourceProtocol {
    
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func doRequestGetPopularList(page: Int, completion: @escaping (Result<[RepositoryResponse]?, NetworkError>) -> Void) {
        self.networkService.doRequest(endpoint: "search/repositories",
                                    parameters: ["q":"language:Kotlin", "sort":"stars", "page":page],
                                    responseType: RepositoryListModel.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
