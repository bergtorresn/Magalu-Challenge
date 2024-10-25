//
//  RepositoryListDataSource.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

protocol PopularListDataSourceProtocol {
    func doRequestGetPopularList(page: Int, completion: @escaping (Result<[RepositoryResponse]?, NetworkError>) -> Void)
}

class PopularListDataSource: PopularListDataSourceProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func doRequestGetPopularList(page: Int, completion: @escaping (Result<[RepositoryResponse]?, NetworkError>) -> Void) {
        self.networkService.doRequest(endpoint: "search/repositories",
                                      method: .get,
                                      parameters: ["q":"language:Kotlin", "sort":"stars", "page":page],
                                      headers: nil,
                                      responseType: PopularListModel.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
