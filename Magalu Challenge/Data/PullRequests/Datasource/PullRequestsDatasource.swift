//
//  PullRequestsDatasource.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation
import RxSwift

protocol PullRequestsDatasourceProtocol {
    func doRequestGetPullRequests(ownerName: String, repositoryName: String)  -> Single<[PullRequestModel]>
}

class PullRequestsDatasource: PullRequestsDatasourceProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func doRequestGetPullRequests(ownerName: String, repositoryName: String) -> Single<[PullRequestModel]> {
        let finalEndpoint = AppStrings.endpointPullRequests
            .replacingOccurrences(of: "ownerName", with: ownerName)
            .replacingOccurrences(of: "repositoryName", with: repositoryName)
        
        return self.networkService.doRequest(endpoint: finalEndpoint,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil)
    }
}
