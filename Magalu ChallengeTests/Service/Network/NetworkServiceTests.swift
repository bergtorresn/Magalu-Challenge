//
//  NetworkServiceTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 29/10/24.
//

import XCTest
import RxSwift
import Alamofire

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    var disposeBag: DisposeBag!
    var mockSession: Session!
    
    override func setUp() {
        super.setUp()
        
        mockSession = MockURLProtocol.makeMockSession()
        networkService = NetworkService(session: mockSession)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        networkService = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testSuccessRequest() {
        let expectation = XCTestExpectation(description: "Should return successful response")
        
        MockURLProtocol.mockResponse = { request in
            let json = """
                {
                   "items":[
                      {
                         "id": 1,
                         "name":"kotlin",
                         "owner":{
                            "login":"JetBrains",
                            "avatar_url":"https://avatars.githubusercontent.com/u/878437?v=4"
                         },
                         "description":"The Kotlin Programming Language.",
                         "stargazers_count":49210,
                         "watchers_count":49210
                      },
                      {
                         "id": 2,
                         "name":"kotlin",
                         "owner":{
                            "login":"JetBrains",
                            "avatar_url":"https://avatars.githubusercontent.com/u/878437?v=4"
                         },
                         "description":"The Kotlin Programming Language.",
                         "stargazers_count":49210,
                         "watchers_count":49210
                      }
                   ]
                }
    """.data(using: .utf8)!
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response, json, nil)
        }
        
        let mockHeaders: HTTPHeaders = [
            "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
        ]
        
        let mockParameters: [String: Any] = [
            "q": "language:Swift",
            "sort": "stars",
            "page": 1
        ]
        
        networkService.doRequest(endpoint: AppStrings.endpointpopularRepositories,
                                 method: .get,
                                 parameters: mockParameters,
                                 headers: mockHeaders)
        .subscribe(
            onSuccess: { (repository: PopularListModel) in
                XCTAssertEqual(repository.items.count, 2)
                XCTAssertEqual(repository.items.first?.name, "kotlin")
                expectation.fulfill()
            },
            onFailure: { error in
                XCTFail("Expected success but got error: \(error)")
            }
        )
        .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
