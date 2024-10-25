//
//  PopularRepositoriesRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

protocol PopularListRepositoryProtocol {
    
    func doRequestGetPopularRepositories(page: Int, completion: @escaping (Result<[RepositoryResponse], NetworkError>) -> Void)
    
}
