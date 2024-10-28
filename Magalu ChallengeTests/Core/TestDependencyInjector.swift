//
//  TestDependencyInjector.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation

import Swinject

class TestDependencyInjector {
    static let shared = TestDependencyInjector()
    let container: Container
    
    init() {
        container = Container()
        registerDependencies()
    }
    
    private func registerDependencies() {
        container.register(NetworkServiceProtocol.self) { _ in
            MockNetworkService()
        }
        
        // ========== DataSources
        container.register(PopularListDataSourceProtocol.self) { resolver in
            return MockPopularListDataSource()
        }
        container.register(PullRequestsDatasourceProtocol.self) { resolver in
            let networkService = resolver.resolve(NetworkServiceProtocol.self)!
            return PullRequestsDatasource(networkService: networkService)
        }
        
        // ========== Repositories
        container.register(PopularListRepositoryProtocol.self) { resolver in
            return MockPopularListRepository()
        }
        container.register(PullRequestsRepositoryProtocol.self) { resolver in
            return MockPullRequestsRepository()
        }
        
        // ========== Usecases
        container.register(GetPullRequestsUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(PullRequestsRepositoryProtocol.self)!
            return GetPullRequestsUseCase(repository: repository)
        }
        container.register(GetPopularRepositoriesUseCaseProtocol.self) { resolver in
            return MockGetPopularRepositoriesUseCase()
        }
        
        // ========== ViewModels
        container.register(ListPullRequestsViewModel.self) { resolver in
            let usecase = resolver.resolve(GetPullRequestsUseCaseProtocol.self)!
            return ListPullRequestsViewModel(usecase: usecase)
        }
        container.register(ListRepositoriesViewModel.self) { resolver in
            let usecase = resolver.resolve(GetPopularRepositoriesUseCaseProtocol.self)!
            return ListRepositoriesViewModel(usecase: usecase)
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType)!
    }
}
