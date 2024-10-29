//
//  PullRequestsRepositoryTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest
import RxSwift

final class PullRequestsRepositoryTests: XCTestCase {
    
    var mockDatasource : MockPullRequestsDataSource!
    var repository: PullRequestsRepository!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockDatasource = TestDependencyInjector.shared.resolve(PullRequestsDatasourceProtocol.self) as? MockPullRequestsDataSource
        repository = PullRequestsRepository(dataSource: mockDatasource)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        repository = nil
        mockDatasource = nil
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
        
        let expectedResult = [model1, model2]
        
        mockDatasource.result = .just(expectedResult)
        
        let expectation = XCTestExpectation(description: "Should return the values")
        
        repository.doRequestGetPullRequests(ownerName: "square", repositoryName: "okhttp")
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
        mockDatasource.result = .error(NetworkError.decodeError)
        
        let expectation = XCTestExpectation(description: "Should return an error")
        
        repository.doRequestGetPullRequests(ownerName: "square", repositoryName: "okhttp")
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
