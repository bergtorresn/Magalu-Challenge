//
//  MockURLProtocol.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 29/10/24.
//

import Foundation
import Alamofire

class MockURLProtocol: URLProtocol {
    
    static var mockResponse: ((URLRequest) -> (HTTPURLResponse?, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.mockResponse else {
            fatalError("MockResponse handler is not set.")
        }
        
        let (response, data, error) = handler(request)
        
        if let response = response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {}
    
    static func makeMockSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return Session(configuration: configuration)
    }
}

