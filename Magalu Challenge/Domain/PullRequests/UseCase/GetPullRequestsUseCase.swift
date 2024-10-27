//
//  GetPullRequestsUseCase.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation
import RxSwift

protocol GetPullRequestsUseCaseProtocol {
    func call(ownerName: String, repositoryName: String) -> Single<[PullRequestEntity]>
}

class GetPullRequestsUseCase: GetPullRequestsUseCaseProtocol {
    
    var repository: PullRequestsRepositoryProtocol
    
    init(repository: PullRequestsRepositoryProtocol) {
        self.repository = repository
    }
    
    func call(ownerName: String, repositoryName: String) -> Single<[PullRequestEntity]> {
        return self.repository.doRequestGetPullRequests(ownerName: ownerName, repositoryName: repositoryName)
    }
}
