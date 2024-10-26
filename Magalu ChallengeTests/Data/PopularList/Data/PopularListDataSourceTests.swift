//
//  PopularListDataSourceTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest
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


final class PopularListDataSourceTests: XCTestCase {
    
    var mockNetworkService : MockNetworkService!
    var dataSource: PopularListDataSource!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkService = MockNetworkService()
        dataSource = PopularListDataSource(networkService: mockNetworkService)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        dataSource = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testResultWithSuccess() {
        
        let repository1 = RepositoryModel(name: "kotlin",
                                          description: "Square’s meticulous HTTP client for the JVM, Android, and GraalVM.",
                                          stargazersCount: 49210,
                                          watchersCount: 49210,
                                          owner: OwnerModel(name: "JetBrains",
                                                            avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        let repository2 = RepositoryModel(name: "okhttp",
                                          description: "The Kotlin Programming Language.",
                                          stargazersCount: 45831,
                                          watchersCount: 45831,
                                          owner: OwnerModel(name: "square",
                                                            avatar: "https://avatars.githubusercontent.com/u/82592?v=4"))
        
        let expectedResult = PopularListModel(items: [repository1, repository2])
        
        mockNetworkService.result = .success(expectedResult)
        
        let expectation = XCTestExpectation(description: "Should return repositories")
        
        dataSource.doRequestGetPopularList(page: 1)
            .subscribe(
                onSuccess: { result in
                    XCTAssertEqual(expectedResult.items.count, result.items.count)
                    XCTAssertEqual(expectedResult.items.first?.name, result.items.first?.name)
                    expectation.fulfill()
                },
                onFailure: { _ in
                    XCTFail("Expected success but got error")
                }
            )
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testResultWithError() {
        mockNetworkService.result = .failure(NetworkError.decodeError(AppStrings.decodeError))
        
        let expectation = XCTestExpectation(description: "Should return an error")
        
        dataSource.doRequestGetPopularList(page: 1)
            .subscribe(
                onSuccess: { _ in
                    XCTFail("Expected error but got success")
                },
                onFailure: { error in
                    var errorMessage: String  = ""
                    let err = error as! NetworkError
                    switch err {
                    case .decodeError(let d):
                        errorMessage = d
                    default:
                        errorMessage = AppStrings.unknownError
                    }
                    XCTAssertEqual(errorMessage, AppStrings.decodeError)
                    expectation.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
}
