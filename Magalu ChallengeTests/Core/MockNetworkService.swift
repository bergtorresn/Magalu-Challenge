//
//  MockNetworkService.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import Alamofire
import RxSwift

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<Decodable, NetworkError>!
    
    func doRequest<T>(endpoint: String,
                      method: HTTPMethod,
                      parameters: [String : Any]?,
                      headers: HTTPHeaders?) -> Single<T> where T : Decodable {
        
        return Single.create { single in
            switch self.result {
            case .success(let data):
                if let responseData = data as? T {
                    single(.success(responseData))
                } else {
                    single(.failure(NetworkError.unknownError(AppStrings.decodeError)))
                }
            case .failure(let error):
                single(.failure(error))
            case .none:
                single(.failure(NetworkError.unknownError(AppStrings.unknownError)))
            }
            
            return Disposables.create()
        }
    }
}
