//
//  MockGetPullRequestsUseCase.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import RxSwift

class MockGetPullRequestsUseCase: GetPullRequestsUseCaseProtocol {
    var result: Result<[PullRequestEntity], NetworkError>!
    
    func call(ownerName: String, repositoryName: String) -> Single<[PullRequestEntity]> {
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

