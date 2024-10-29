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
    var mockSuccessUseCase: MockGetPopularRepositoriesUseCase!
    var mockFailureUseCase: MockGetPopularRepositoriesUseCase!
    
    override func setUp() {
        super.setUp()
        mockSuccessUseCase = TestDependencyInjector.shared.resolve(GetPopularRepositoriesUseCaseProtocol.self, name: "success") as? MockGetPopularRepositoriesUseCase
        mockFailureUseCase = TestDependencyInjector.shared.resolve(GetPopularRepositoriesUseCaseProtocol.self, name: "failure") as? MockGetPopularRepositoriesUseCase
    }
    
    override func tearDown() {
        mockSuccessUseCase = nil
        mockFailureUseCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        viewModel = ListRepositoriesViewModel(usecase: mockSuccessUseCase)
        XCTAssertEqual(self.viewModel.uiState, .Init)
        XCTAssertTrue(self.viewModel.items.isEmpty)
    }
    
    func testDoRequestGetPopularRepositoriesWithoutPaginationAndSuccessState() {
        viewModel = ListRepositoriesViewModel(usecase: mockSuccessUseCase)

        let mockRepositories: [RepositoryEntity] = [RepositoryEntity(id: 1,
                                                                     name: "kotlin",
                                                                     description: "The Kotlin Programming Language.",
                                                                     stargazersCount: 49210,
                                                                     watchersCount: 49210,
                                                                     owner: OwnerEntity(name: "JetBrains",
                                                                                        avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))]
        
        mockSuccessUseCase.result = .success(mockRepositories)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(self.viewModel.items.count, mockRepositories.count)
        XCTAssertEqual(self.viewModel.uiState, .Success)
    }
    
    func testDoRequestGetPopularRepositoriesWithPaginationAndSuccessState() {
        viewModel = ListRepositoriesViewModel(usecase: mockSuccessUseCase)

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
        
        mockSuccessUseCase.result = .success(mockRepositories1)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(self.viewModel.items.count, mockRepositories1.count)
        XCTAssertEqual(self.viewModel.uiState, .Success)
        
        mockSuccessUseCase.result = .success(mockRepositories2)
        
        viewModel.doRequestGetPopularRepositories(isPagination: true)
        
        XCTAssertEqual(self.viewModel.items.count, 2)
    }
    
    func testDoRequestGetPopularRepositoriesWithFailureState() {
        viewModel = ListRepositoriesViewModel(usecase: mockFailureUseCase)

        mockFailureUseCase.result = .failure(NetworkError.unknownError)
        
        viewModel.doRequestGetPopularRepositories(isPagination: false)
        
        XCTAssertEqual(viewModel.uiState, .ApiError(AppStrings.unknownError))
    }
    
    func testPaginationDoRequestGetPopularRepositoriesWithFailure() {
        viewModel = ListRepositoriesViewModel(usecase: mockFailureUseCase)

        let errorWrapper = ErrorWrapper(message: NetworkError.unknownError.description)
        
        mockFailureUseCase.result = .failure(NetworkError.unknownError)
        
        viewModel.doRequestGetPopularRepositories(isPagination: true)
        
        XCTAssertEqual(viewModel.errorWrapper?.message, AppStrings.unknownError.description)
    }
    
    func testSetErrorWrapperToNull() {
        viewModel = ListRepositoriesViewModel(usecase: mockFailureUseCase)

        mockFailureUseCase.result = .failure(NetworkError.unknownError)
        
        viewModel.doRequestGetPopularRepositories(isPagination: true)

        viewModel.clearError()
        
        XCTAssertNil(viewModel.errorWrapper)
    }
}
