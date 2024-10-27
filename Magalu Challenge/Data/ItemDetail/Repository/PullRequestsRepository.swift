//
//  PullRequestsRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation
import RxSwift


class PullRequestsRepository: PullRequestsRepositoryProtocol {
    
    var dataSource : PullRequestsDatasourceProtocol
    
    init(dataSource: PullRequestsDatasourceProtocol) {
        self.dataSource = dataSource
    }
    
    func doRequestGetPullRequests(ownerName: String, repositoryName: String) -> RxSwift.Single<[PullRequestEntity]> {
        return self.dataSource.doRequestGetPullRequests(ownerName: ownerName, repositoryName: repositoryName).map { pullRequests in
            return PullRequestEntity.toEntity(input: pullRequests)
        }
    }
}
