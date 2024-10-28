//
//  GetPullRequestsUseCaseTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest
import RxSwift

final class GetPullRequestsUseCaseTests: XCTestCase {
    
    var useCase : GetPullRequestsUseCase!
    var mockRepository: MockPullRequestsRepository!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockRepository = TestDependencyInjector.shared.resolve(PullRequestsRepositoryProtocol.self) as? MockPullRequestsRepository
        useCase = GetPullRequestsUseCase(repository: mockRepository)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testCallWithSuccess() {
        
        let entity1 = PullRequestEntity(id: 1,
                                        title: "Fix pymdownx.emoji extension warning",
                                        body: "## Description\r\n - Fix pymdownx.emoji",
                                        url: "https://github.com/square/okhttp/pull/8559",
                                        createdAt: "2024-10-19T18:23:17Z",
                                        user: PullRequestUserEntity(name: "desiderantes",
                                                                    avatar: "https://avatars.githubusercontent.com/u/1703429?v=4"))
        let entity2 = PullRequestEntity(id: 1,
                                        title: "Fix pymdownx.emoji extension warning",
                                        body: "## Description\r\n - Fix pymdownx.emoji",
                                        url: "https://github.com/square/okhttp/pull/8559",
                                        createdAt: "2024-10-19T18:23:17Z",
                                        user: PullRequestUserEntity(name: "jaredsburrows",
                                                                   avatar: "https://avatars.githubusercontent.com/u/1739848?v=4"))
        
        let expectedValues = [entity1, entity2]
        
        mockRepository.result = .just(expectedValues)
        
        let expectation = XCTestExpectation(description: "Should return the values")
        
        useCase.call(ownerName: "square", repositoryName: "okhttp")
            .subscribe(
                onSuccess: { result in
                    XCTAssertEqual(result.count, result.count)
                    XCTAssertEqual(result.first?.title, result.first?.title)
                    expectation.fulfill()
                },
                onFailure: { _ in
                    XCTFail("Expected success but got error")
                }
            )
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCallWithError() {
        mockRepository.result = .error(NetworkError.decodeError(AppStrings.decodeError))
            
            let expectation = XCTestExpectation(description: "Should return an error")
            
            useCase.call(ownerName: "square", repositoryName: "okhttp")
                .subscribe(
                    onSuccess: { _ in
                        XCTFail("Expected error but got success")
                    },
                    onFailure: { error in
                        let err = error as! NetworkError
                        XCTAssertEqual( err.description, AppStrings.decodeError)
                        expectation.fulfill()
                    }
                )
                .disposed(by: disposeBag)
            
            wait(for: [expectation], timeout: 1.0)
        }
}



