//
//  PopularRepositoriesRepository.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import RxSwift

protocol PopularListRepositoryProtocol {
    
    func doRequestGetPopularList(page: Int) -> Single<[RepositoryEntity]>
}
