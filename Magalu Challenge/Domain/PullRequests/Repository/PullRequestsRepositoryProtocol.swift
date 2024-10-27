//
//  PullRequestsRepositoryProtocol.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation
import RxSwift

protocol PullRequestsRepositoryProtocol {
    
    func doRequestGetPullRequests(ownerName: String, repositoryName: String) -> Single<[PullRequestEntity]>

}
