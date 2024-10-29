//
//  MockPopularListDataSource.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import RxSwift

class MockPopularListDataSource: PopularListDataSourceProtocol{
   
    var result: Single<PopularListModel>!
    
    func doRequestGetPopularList(page: Int) -> Single<PopularListModel> {
        return result
    }
}
