//
//  ListPullRequestsViewModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest
import RxSwift

final class ListPullRequestsViewModelTests: XCTestCase {

    var viewModel: ListPullRequestsViewModel!
    var mockUseCase: MockGetPullRequestsUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = TestDependencyInjector.shared.resolve(GetPullRequestsUseCaseProtocol.self) as? MockGetPullRequestsUseCase
        viewModel = ListPullRequestsViewModel(usecase: mockUseCase)
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(self.viewModel.uiState, .Init)
        XCTAssertTrue(self.viewModel.items.isEmpty)
    }
    
    func testdoRequestGetPullRequestsUseCaseWithSuccessState() {
        
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
                
        let resultExpected = [entity1, entity2]
        
        mockUseCase.result = .success(resultExpected)
        
        viewModel.doRequestGetPullRequestsUseCase(ownerName: "square", repositoryName: "okhttp")

        XCTAssertEqual(self.viewModel.items.count, resultExpected.count)
        XCTAssertEqual(self.viewModel.uiState, .Success)
    }
    
    func testdoRequestGetPullRequestsUseCaseWithErrorState() {
                
        mockUseCase.result = .failure(NetworkError.unknownError)
        
        viewModel.doRequestGetPullRequestsUseCase(ownerName: "square", repositoryName: "okhttp")

        XCTAssertEqual(viewModel.uiState, .ApiError(AppStrings.unknownError))
    }
}
