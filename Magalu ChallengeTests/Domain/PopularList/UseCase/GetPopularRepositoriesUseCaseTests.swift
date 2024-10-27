//
//  GetPopularRepositoriesUseCaseTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest
import RxSwift

class MockPopularListRepository: PopularListRepositoryProtocol{
    var result: Single<[RepositoryEntity]>!
    
    func doRequestGetPopularList(page: Int) -> Single<[RepositoryEntity]> {
        return result
    }
}

final class GetPopularRepositoriesUseCaseTests: XCTestCase {
    
    var useCase : GetPopularRepositoriesUseCase!
    var mockRepository: MockPopularListRepository!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockPopularListRepository()
        useCase = GetPopularRepositoriesUseCase(repository: mockRepository!)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testCallWithSuccess() {
        
        let repositoryEntity1 = RepositoryEntity(id:1,
                                                 name: "kotlin",
                                                 description: "Square’s meticulous HTTP client for the JVM, Android, and GraalVM.",
                                                 stargazersCount: 49210,
                                                 watchersCount: 49210,
                                                 owner: OwnerEntity(name: "JetBrains",
                                                                    avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        let repositoryEntity2 = RepositoryEntity(id: 2,
                                                 name: "okhttp",
                                                 description: "The Kotlin Programming Language.",
                                                 stargazersCount: 45831,
                                                 watchersCount: 45831,
                                                 owner: OwnerEntity(name: "square",
                                                                    avatar: "https://avatars.githubusercontent.com/u/82592?v=4"))
        
        let expectedRepositories = [repositoryEntity1,repositoryEntity2]
        
        mockRepository.result = .just(expectedRepositories)
        
        let expectation = XCTestExpectation(description: "Should return repositories")
        
        useCase.call(page: 1)
            .subscribe(
                onSuccess: { repositories in
                    XCTAssertEqual(repositories.count, expectedRepositories.count)
                    XCTAssertEqual(repositories.first?.name, expectedRepositories.first?.name)
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
            
            useCase.call(page: 1)
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




