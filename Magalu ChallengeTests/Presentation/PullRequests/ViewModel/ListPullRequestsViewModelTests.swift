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
    var mockSuccessUseCase: MockGetPullRequestsUseCase!
    var mockFailureUseCase: MockGetPullRequestsUseCase!

    override func setUp() {
        super.setUp()
        mockSuccessUseCase = TestDependencyInjector.shared.resolve(GetPullRequestsUseCaseProtocol.self, name: "success") as? MockGetPullRequestsUseCase
        mockFailureUseCase = TestDependencyInjector.shared.resolve(GetPullRequestsUseCaseProtocol.self, name: "failure") as? MockGetPullRequestsUseCase
    }
    
    override func tearDown() {
        mockSuccessUseCase = nil
        mockFailureUseCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        viewModel = ListPullRequestsViewModel(usecase: mockSuccessUseCase)
        XCTAssertEqual(self.viewModel.uiState, .Init)
        XCTAssertTrue(self.viewModel.items.isEmpty)
    }
    
    func testdoRequestGetPullRequestsUseCaseWithSuccessState() {
        
        viewModel = ListPullRequestsViewModel(usecase: mockSuccessUseCase)

        
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
        
        mockSuccessUseCase.result = .success(resultExpected)
        
        viewModel.doRequestGetPullRequestsUseCase(ownerName: "square", repositoryName: "okhttp")

        XCTAssertEqual(self.viewModel.items.count, resultExpected.count)
        XCTAssertEqual(self.viewModel.uiState, .Success)
    }
    
    func testdoRequestGetPullRequestsUseCaseWithErrorState() {
        
        viewModel = ListPullRequestsViewModel(usecase: mockFailureUseCase)
                
        mockFailureUseCase.result = .failure(NetworkError.unknownError)
        
        viewModel.doRequestGetPullRequestsUseCase(ownerName: "square", repositoryName: "okhttp")

        XCTAssertEqual(viewModel.uiState, .ApiError(AppStrings.unknownError))
    }
}
