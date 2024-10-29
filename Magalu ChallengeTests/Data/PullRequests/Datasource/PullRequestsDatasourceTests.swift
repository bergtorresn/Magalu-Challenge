//
//  PullRequestsDatasourceTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest
import RxSwift

final class PullRequestsDatasourceTests: XCTestCase {

    var mockNetworkService: MockNetworkService!
    var dataSource: PullRequestsDatasource!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = TestDependencyInjector.shared.resolve(NetworkServiceProtocol.self) as? MockNetworkService
        dataSource = PullRequestsDatasource(networkService: mockNetworkService)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        dataSource = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testResultWithSuccess() {
        
        let model1 = PullRequestModel(id: 1,
                                      title: "Fix pymdownx.emoji extension warning",
                                      body: "## Description\r\n - Fix pymdownx.emoji",
                                      url: "https://github.com/square/okhttp/pull/8559",
                                      createdAt: "2024-10-19T18:23:17Z",
                                      user: PullRequestUserModel(name: "desiderantes",
                                                                 avatar: "https://avatars.githubusercontent.com/u/1703429?v=4"))
        let model2 = PullRequestModel(id: 1,
                                      title: "Fix pymdownx.emoji extension warning",
                                      body: "## Description\r\n - Fix pymdownx.emoji",
                                      url: "https://github.com/square/okhttp/pull/8559",
                                      createdAt: "2024-10-19T18:23:17Z",
                                      user: PullRequestUserModel(name: "jaredsburrows",
                                                                 avatar: "https://avatars.githubusercontent.com/u/1739848?v=4"))
        
        let expectedResult =  [model1, model2]
        
        mockNetworkService.result = .success(expectedResult)
        
        let expectation = XCTestExpectation(description: "Should return the values")
        
        dataSource.doRequestGetPullRequests(ownerName: "square", repositoryName: "okhttp")
            .subscribe(
                onSuccess: { result in
                    XCTAssertEqual(expectedResult.count, result.count)
                    XCTAssertEqual(expectedResult.first?.title, result.first?.title)
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
        mockNetworkService.result = .failure(NetworkError.decodeError)
        
        let expectation = XCTestExpectation(description: "Should return an error")
        
        dataSource.doRequestGetPullRequests(ownerName: "square", repositoryName: "okhttp")
            .subscribe(
                onSuccess: { _ in
                    XCTFail("Expected error but got success")
                },
                onFailure: { error in
                    let err = error as! NetworkError
                    XCTAssertEqual(err.description, AppStrings.decodeError)
                    expectation.fulfill()
                }
            )
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
