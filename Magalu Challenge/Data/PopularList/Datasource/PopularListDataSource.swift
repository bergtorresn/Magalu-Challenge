//
//  RepositoryListDataSource.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import RxSwift

protocol PopularListDataSourceProtocol {
    func doRequestGetPopularList(page: Int) -> Single<PopularListModel>
}

class PopularListDataSource: PopularListDataSourceProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func doRequestGetPopularList(page: Int) -> Single<PopularListModel> {
        return self.networkService.doRequest(endpoint: AppStrings.endpointpopularRepositories,
                                             method: .get,
                                             parameters: ["q":"language:Swift", "sort":"stars", "page":page],
                                             headers: nil)
    }
}
