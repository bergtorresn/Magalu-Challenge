//
//  NetworkService.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import Alamofire
import RxSwift

enum NetworkError: Error {
    case unknownError
    case serverError
    case decodeError
    case noInternetConnection
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .unknownError:
            return AppStrings.unknownError
        case .serverError:
            return AppStrings.serverError
        case .decodeError:
            return AppStrings.decodeError
        case .noInternetConnection:
            return AppStrings.noInternetConnection
        }
    }
}

protocol NetworkServiceProtocol {
    func doRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?) -> Single<T>
}

class NetworkService : NetworkServiceProtocol{
    
    private let session: Session
    static let shared = NetworkService()
    private let reachabilityManager = NetworkReachabilityManager()
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func doRequest<T>(endpoint: String,
                      method: Alamofire.HTTPMethod,
                      parameters: [String : Any]?,
                      headers: Alamofire.HTTPHeaders?) -> Single<T> where T : Decodable {
        
        guard reachabilityManager?.isReachable == true else {
            return Single.error(NetworkError.noInternetConnection)
        }
        
        var defaultHeards: HTTPHeaders = ["Content-Type": "application/json"]
        
        if headers != nil {
            for header in headers! {
                defaultHeards.add(header)
            }
        }
        
        return Single.create { single in
            let request = self.session.request(AppStrings.baseURL + endpoint,
                                               method: method,
                                               parameters: parameters,
                                               encoding: URLEncoding.queryString,
                                               headers: defaultHeards)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        single(.success(data))
                    case .failure(let error):
                        single(.failure(self.handlerErrors(error: error)))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func handlerErrors(error: AFError) -> NetworkError {
        if error.isResponseSerializationError {
            return .decodeError
        } else {
            if let statusCode = error.responseCode {
                switch statusCode {
                case 400...499:
                    return .serverError
                case 500...599:
                    return .serverError
                default:
                    return .unknownError
                }
            }
        }
        
        return .unknownError
    }
}
