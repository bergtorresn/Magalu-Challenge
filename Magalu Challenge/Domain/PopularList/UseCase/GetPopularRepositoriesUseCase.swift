//
//  GetPopularRepoisotiesUseCase.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import RxSwift

protocol GetPopularRepositoriesUseCaseProtocol {
    func call(page: Int) -> Single<[RepositoryEntity]>
}

class GetPopularRepositoriesUseCase: GetPopularRepositoriesUseCaseProtocol {
    
    var repository: PopularListRepositoryProtocol
    
    init(repository: PopularListRepositoryProtocol) {
        self.repository = repository
    }
    
    func call(page: Int) -> RxSwift.Single<[RepositoryEntity]> {
        return self.repository.doRequestGetPopularList(page: page)
    }
}
