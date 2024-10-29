//
//  MockPopularListRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import RxSwift

class MockPopularListRepository: PopularListRepositoryProtocol{
    var result: Single<[RepositoryEntity]>!
    
    func doRequestGetPopularList(page: Int) -> Single<[RepositoryEntity]> {
        return result
    }
}
