//
//  ListViewModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 27/10/24.
//

import XCTest
import RxSwift
import Combine

class MockGetPopularRepositoriesUseCase: GetPopularRepositoriesUseCaseProtocol {
    var result: Result<[RepositoryEntity], NetworkError>!
    
    func call(page: Int) -> Single<[RepositoryEntity]> {
        switch result {
        case .success(let success):
            return .just(success)
        case .failure(let failure):
            return .error(failure)
        default:
            fatalError("Result not found")
        }
    }
}

final class ListViewModelTests: XCTestCase {
    
    var viewModel: ListViewModel!
    var mockUseCase: MockGetPopularRepositoriesUseCase!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetPopularRepositoriesUseCase()
        viewModel = ListViewModel(usecase: mockUseCase)
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testDoRequestGetPopularRepositoriesLoadingState() {
        
        let expectation = XCTestExpectation(description: "state must be Loading")
        
        mockUseCase.result = .success([])
        
        viewModel.$uiState
            .dropFirst()
            .sink { state in
                if state == .Loading {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        viewModel.doRequestGetPopularRepositories(page: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDoRequestGetPopularRepositoriesSuccessWithDataState() {
        
        let expectation = XCTestExpectation(description: "state must be success with data")
        
        let mockRepositories :[RepositoryEntity] = [RepositoryEntity(id: 1,
                                                                     name: "kotlin",
                                                                     description: "The Kotlin Programming Language.",
                                                                     stargazersCount: 49210,
                                                                     watchersCount: 49210,
                                                                     owner: OwnerEntity(name: "JetBrains",
                                                                                        avatar: "https://avatars.githubusercontent.com/u/878437?v=4"))]
        
        mockUseCase.result = .success(mockRepositories)
        
        viewModel.$uiState
            .dropFirst()
            .sink { state in
                if case .Success(let repositories) = state {
                    XCTAssertEqual(repositories.count, mockRepositories.count)
                    XCTAssertEqual(repositories.first?.name, mockRepositories.first?.name)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        viewModel.doRequestGetPopularRepositories(page: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDoRequestGetPopularRepositoriesSuccessWithoutDataState() {
        
        let expectation = XCTestExpectation(description: "state must be success without data")
        
        let mockRepositories:[RepositoryEntity] = []
        
        mockUseCase.result = .success(mockRepositories)
        
        viewModel.$uiState
            .dropFirst()
            .sink { state in
                if case .Success(let repositories) = state {
                    XCTAssertEqual(repositories.isEmpty, mockRepositories.isEmpty)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        viewModel.doRequestGetPopularRepositories(page: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDoRequestGetPopularRepositoriesFailureWithUnknoewErrorState() {
        
        let expectation = XCTestExpectation(description: "state must be failure with unknown error")
        
        let error = NetworkError.unknownError(AppStrings.unknownError)
        
        mockUseCase.result = .failure(error)
        
        viewModel.$uiState
            .dropFirst()
            .sink { state in
                if case .ApiError(let errorMessage) = state {
                    XCTAssertEqual(errorMessage, AppStrings.unknownError)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        viewModel.doRequestGetPopularRepositories(page: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDoRequestGetPopularRepositoriesFailureWithDecodeErrorState() {
        
        let expectation = XCTestExpectation(description: "state must be failure with decode error")
        
        let error = NetworkError.decodeError(AppStrings.decodeError)
        
        mockUseCase.result = .failure(error)
        
        viewModel.$uiState
            .dropFirst()
            .sink { state in
                if case .ApiError(let errorMessage) = state {
                    XCTAssertEqual(errorMessage, AppStrings.decodeError)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        viewModel.doRequestGetPopularRepositories(page: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDoRequestGetPopularRepositoriesFailureWithServerErrorState() {
        
        let expectation = XCTestExpectation(description: "state must be failure with server error")
        
        let error = NetworkError.serverError(AppStrings.serverError)
        
        mockUseCase.result = .failure(error)
        
        viewModel.$uiState
            .dropFirst()
            .sink { state in
                if case .ApiError(let errorMessage) = state {
                    XCTAssertEqual(errorMessage, AppStrings.serverError)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        viewModel.doRequestGetPopularRepositories(page: 1)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
