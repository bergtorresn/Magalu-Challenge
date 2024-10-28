//
//  MockPullRequestsDataSource.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import RxSwift

class MockPullRequestsDataSource: PullRequestsDatasourceProtocol{
    
    var result: Single<[PullRequestModel]>!
    
    func doRequestGetPullRequests(ownerName: String, repositoryName: String) -> Single<[PullRequestModel]>{
        return result
    }
}
