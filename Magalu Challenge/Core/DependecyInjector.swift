//
//  DependecyInjector.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 28/10/24.
//

import Foundation
import Swinject

class DependecyInjector {
    
    static let shared = DependecyInjector()
    private let container = Container()
    
    private init(){
        registerDependencies()
    }
    
    private func registerDependencies(){
        // ========== NetworkService
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }.inObjectScope(.container)
        
        //  ========== DataSource
        container.register(PopularListDataSourceProtocol.self) { r in
            return PopularListDataSource(networkService: r.resolve(NetworkServiceProtocol.self)!)
        }.inObjectScope(.container)
        container.register(PullRequestsDatasourceProtocol.self) { r in
            return PullRequestsDatasource(networkService: r.resolve(NetworkServiceProtocol.self)!)
        }.inObjectScope(.container)
        
        //  ========== Repositories
        container.register(PopularListRepositoryProtocol.self) { r in
            return PopularListRepository(dataSource: r.resolve(PopularListDataSourceProtocol.self)!)
        }.inObjectScope(.container)
        container.register(PullRequestsRepositoryProtocol.self) { r in
            return PullRequestsRepository(dataSource: r.resolve(PullRequestsDatasourceProtocol.self)!)
        }.inObjectScope(.container)
        
        //  ========== UseCases
        container.register(GetPopularRepositoriesUseCaseProtocol.self) { r in
            return GetPopularRepositoriesUseCase(repository: r.resolve(PopularListRepositoryProtocol.self)!)
        }.inObjectScope(.transient)
        container.register(GetPullRequestsUseCaseProtocol.self) { r in
            return GetPullRequestsUseCase(repository: r.resolve(PullRequestsRepositoryProtocol.self)!)
        }.inObjectScope(.transient)
        
        //  ========== ViewModels
        container.register(ListRepositoriesViewModel.self) { r in
            return ListRepositoriesViewModel(usecase: r.resolve(GetPopularRepositoriesUseCaseProtocol.self)!)
        }.inObjectScope(.transient)
        container.register(ListPullRequestsViewModel.self) { r in
            return ListPullRequestsViewModel(usecase: r.resolve(GetPullRequestsUseCaseProtocol.self)!)
        }.inObjectScope(.transient)
        container.register(WebViewViewModel.self) { (_, url: String) in
            return WebViewViewModel(url: url)
        }.inObjectScope(.transient)
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType)!
    }
    
    func resolveWithArgs<Service, Arg>(_ serviceType: Service.Type, argument: Arg) -> Service {
        return container.resolve(serviceType, argument: argument)!
    }
}
