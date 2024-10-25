//
//  NetworkService.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case unknownError(String)
    case notFound(String)
    case serverError(String)
    case decodeError(String)
}

protocol NetworkServiceProtocol {
    func doRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkService : NetworkServiceProtocol{
    
    private let baseURL = "https://api.github.com/"
    private let session: Session
    static let shared = NetworkService()
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func doRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void){
            
            var defaultHeards: HTTPHeaders = ["Content-Type": "application/json"]
            
            if let customHeaders = headers {
                for header in customHeaders {
                    defaultHeards.add(header)
                }
            }
            
            session.request(baseURL + endpoint,
                            method: method,
                            parameters: parameters,
                            encoding: URLEncoding.queryString,
                            headers: defaultHeards)
            .validate()
            .responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(self.handlerErrors(error: error)))
                }
            }
        }
    
    private func handlerErrors(error: AFError) -> NetworkError {
        if error.isResponseSerializationError {
            return .decodeError("Decode Error")
        } else {
            if let statusCode = error.responseCode {
                switch  statusCode {
                case 400...499:
                    return .notFound("Not Found")
                case 500...599:
                    return .serverError("Server Error")
                default:
                    return .unknownError("Unknown Error")
                }
            }
        }
        
        return .unknownError("Unknown Error")
    }
}
