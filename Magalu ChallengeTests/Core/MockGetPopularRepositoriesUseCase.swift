//
//  MockGetPopularRepositoriesUseCase.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import RxSwift

class MockGetPopularRepositoriesUseCase: GetPopularRepositoriesUseCaseProtocol {
    var result: Result<[RepositoryEntity], NetworkError>!
    
    func call(page: Int) -> Single<[RepositoryEntity]> {
        switch result {
        case .success(let success):
            return .just(success)
        case .failure(let failure):
            return .error(failure)
        default:
            fatalError("Result not found")
        }
    }
}
