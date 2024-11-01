//
//  PopularListRepositoryTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 26/10/24.
//

import XCTest
import RxSwift

final class PopularListRepositoryTests: XCTestCase {
    
    var mockDatasource : MockPopularListDataSource!
    var repository: PopularListRepository!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockDatasource = TestDependencyInjector.shared.resolve(PopularListDataSourceProtocol.self) as? MockPopularListDataSource
        repository = PopularListRepository(dataSource: mockDatasource)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        repository = nil
        mockDatasource = nil
        super.tearDown()
    }

    func testResultWithSuccess() {
        
        let repository1 = RepositoryModel(id: 1,
                                          name: "kotlin",
                                                 description: "Square’s meticulous HTTP client for the JVM, Android, and GraalVM.",
                                                 stargazersCount: 49210,
                                                 watchersCount: 49210,
                                                 owner: OwnerModel(name: "JetBrains",
                                                                    avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))
        let repository2 = RepositoryModel(id: 1,
                                          name: "okhttp",
                                                 description: "The Kotlin Programming Language.",
                                                 stargazersCount: 45831,
                                                 watchersCount: 45831,
                                                 owner: OwnerModel(name: "square",
                                                                    avatar: "https://avatars.githubusercontent.com/u/82592?v=4"))
        
        let expectedResult = PopularListModel(items: [repository1, repository2])
                
        mockDatasource.result = .just(expectedResult)
        
        let expectation = XCTestExpectation(description: "Should return repositories")
        
        repository.doRequestGetPopularList(page: 1)
            .subscribe(
                onSuccess: { result in
                                    
                    XCTAssertEqual(expectedResult.items.count, result.count)
                    XCTAssertEqual(expectedResult.items.first?.name, result.first?.name)
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
            
            repository.doRequestGetPopularList(page: 1)
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
