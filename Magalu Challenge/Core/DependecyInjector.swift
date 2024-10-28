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
        // ========== Start Singletons
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }.inObjectScope(.container)
        // ========== End Singletons
        
        //  ========== Start Popular Repositories
        container.register(PopularListDataSourceProtocol.self) { r in
            return PopularListDataSource(networkService: r.resolve(NetworkServiceProtocol.self)!)
        }
        
        container.register(PopularListRepositoryProtocol.self) { r in
            return PopularListRepository(dataSource: r.resolve(PopularListDataSourceProtocol.self)!)
        }
        
        container.register(GetPopularRepositoriesUseCaseProtocol.self) { r in
            return GetPopularRepositoriesUseCase(repository: r.resolve(PopularListRepositoryProtocol.self)!)
        }
        
        container.register(ListRepositoriesViewModel.self) { r in
            return ListRepositoriesViewModel(usecase: r.resolve(GetPopularRepositoriesUseCaseProtocol.self)!)
        }
        //  ========== End Popular Repositories
        
        //  ========== Start Pull Requests
        container.register(PullRequestsDatasourceProtocol.self) { r in
            return PullRequestsDatasource(networkService: r.resolve(NetworkServiceProtocol.self)!)
        }
        
        container.register(PullRequestsRepositoryProtocol.self) { r in
            return PullRequestsRepository(dataSource: r.resolve(PullRequestsDatasourceProtocol.self)!)
        }
        
        container.register(GetPullRequestsUseCaseProtocol.self) { r in
            return GetPullRequestsUseCase(repository: r.resolve(PullRequestsRepositoryProtocol.self)!)
        }
        
        container.register(ListPullRequestsViewModel.self) { r in
            return ListPullRequestsViewModel(usecase: r.resolve(GetPullRequestsUseCaseProtocol.self)!)
        }
        //  ========== End Pull Requests
        
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        return container.resolve(serviceType)!
    }
}
