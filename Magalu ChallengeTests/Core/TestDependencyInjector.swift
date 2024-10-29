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
        container.register(GetPullRequestsUseCaseProtocol.self, name: "success") { resolver in
            return MockGetPullRequestsUseCase(result: .success([]))
        }
        container.register(GetPullRequestsUseCaseProtocol.self, name: "failure") { resolver in
            return MockGetPullRequestsUseCase(result: .failure(NetworkError.unknownError))
        }
        container.register(GetPopularRepositoriesUseCaseProtocol.self , name: "success") { resolver in
            return MockGetPopularRepositoriesUseCase(result: .success([]))
        }
        container.register(GetPopularRepositoriesUseCaseProtocol.self, name: "failure") { resolver in
            return MockGetPopularRepositoriesUseCase(result: .failure(NetworkError.unknownError))
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service {
        return container.resolve(serviceType, name: name)!
    }
}
