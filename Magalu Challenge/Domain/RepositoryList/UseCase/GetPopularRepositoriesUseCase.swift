//
//  GetPopularRepoisotiesUseCase.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

protocol GetPopularRepositoriesUseCaseProtocol {
    func call(page: Int, completion: @escaping (Result<[RepositoryEntity], NetworkError>) -> Void)
}

class GetPopularRepositoriesUseCase: GetPopularRepositoriesUseCaseProtocol {
    
    var repository: PopularListRepositoryProtocol
    
    init(repository: PopularListRepositoryProtocol) {
        self.repository = repository
    }
    
    func call(page: Int, completion: @escaping (Result<[RepositoryEntity], NetworkError>) -> Void) {
        self.repository.doRequestGetPopularList(page: page) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
