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
    case unknownError(String)
    case serverError(String)
    case decodeError(String)
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
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func doRequest<T>(endpoint: String,
                      method: Alamofire.HTTPMethod,
                      parameters: [String : Any]?,
                      headers: Alamofire.HTTPHeaders?) -> Single<T> where T : Decodable {
        
        var defaultHeards: HTTPHeaders = ["Content-Type": "application/json"]
        
        if let customHeaders = headers {
            for header in customHeaders {
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
            return .decodeError(AppStrings.decodeError)
        } else {
            if let statusCode = error.responseCode {
                switch statusCode {
                case 400...499:
                    return .serverError(AppStrings.notFoundError)
                case 500...599:
                    return .serverError(AppStrings.serverError)
                default:
                    return .unknownError(AppStrings.unknownError)
                }
            }
        }
        
        return .unknownError(AppStrings.unknownError)
    }
}
