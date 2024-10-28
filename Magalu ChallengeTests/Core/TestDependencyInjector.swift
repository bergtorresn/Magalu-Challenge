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
            return MockPullRequestsDataSource()
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
            return MockGetPullRequestsUseCase()
        }
        container.register(GetPopularRepositoriesUseCaseProtocol.self) { resolver in
            return MockGetPopularRepositoriesUseCase()
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType)!
    }
}
