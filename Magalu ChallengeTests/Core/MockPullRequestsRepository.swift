//
//  MockPullRequestsRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import RxSwift

class MockPullRequestsRepository: PullRequestsRepositoryProtocol{
    var result: Single<[PullRequestEntity]>!
    
    func doRequestGetPullRequests(ownerName: String, repositoryName: String) -> Single<[PullRequestEntity]> {
        return result
    }
}
