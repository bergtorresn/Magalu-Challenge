//
//  ListViewModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 27/10/24.
//

import XCTest
import RxSwift

final class ListViewModelTests: XCTestCase {
    
    var viewModel: ListRepositoriesViewModel!
    var mockUseCase: MockGetPopularRepositoriesUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = TestDependencyInjector.shared.resolve(GetPopularRepositoriesUseCaseProtocol.self) as? MockGetPopularRepositoriesUseCase
        viewModel = ListRepositoriesViewModel(usecase: mockUseCase)
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
    
    func testDoRequestGetPopularRepositoriesWithoutPaginationAndSuccessState() {
        
        let mockRepositories: [RepositoryEntity] = [RepositoryEntity(id: 1,
                                                                     name: "kotlin",
                                                                     description: "The Kotlin Programming Language.",
                                                                     stargazersCount: 49210,
                                                                     watchersCount: 49210,
                                                                     owner: OwnerEntity(name: "JetBrains",
                                                                                        avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))]
        
        mockUseCase.result = .success(mockRepositories)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(self.viewModel.items.count, mockRepositories.count)
        XCTAssertEqual(self.viewModel.uiState, .Success)
    }
    
    func testDoRequestGetPopularRepositoriesWithPaginationAndSuccessState() {
        
        let mockRepositories1: [RepositoryEntity] = [RepositoryEntity(id: 1,
                                                                      name: "kotlin",
                                                                      description: "The Kotlin Programming Language.",
                                                                      stargazersCount: 49210,
                                                                      watchersCount: 49210,
                                                                      owner: OwnerEntity(name: "JetBrains",
                                                                                         avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))]
        
        let mockRepositories2: [RepositoryEntity] = [RepositoryEntity(id: 2,
                                                                      name: "kotlin2",
                                                                      description: "The Kotlin Programming Language.2",
                                                                      stargazersCount: 49210,
                                                                      watchersCount: 49210,
                                                                      owner: OwnerEntity(name: "JetBrains",
                                                                                         avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))]
        
        mockUseCase.result = .success(mockRepositories1)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(self.viewModel.items.count, mockRepositories1.count)
        XCTAssertEqual(self.viewModel.uiState, .Success)
        
        mockUseCase.result = .success(mockRepositories2)
        
        viewModel.doRequestGetPopularRepositories(isPagination: true)
        
        XCTAssertEqual(self.viewModel.items.count, 2)
    }
    
    func testDoRequestGetPopularRepositoriesWithFailureStateAndUnknownError() {
        
        mockUseCase.result = .failure(NetworkError.unknownError)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(viewModel.uiState, .ApiError(AppStrings.unknownError))
    }
    
    func testDoRequestGetPopularRepositoriesWithFailureStateAndDecodeError() {
        
        mockUseCase.result = .failure(NetworkError.decodeError)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(viewModel.uiState, .ApiError(AppStrings.decodeError))
    }
    
    func testDoRequestGetPopularRepositoriesWithFailureStateAnServerError() {
        
        mockUseCase.result = .failure(NetworkError.serverError)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(viewModel.uiState, .ApiError(AppStrings.serverError))
    }
}
