//
//  ListRepositoriesViewModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import RxSwift
import Network

enum ListRepositoriesState: Equatable {
    case Init
    case Loading
    case Success
    case ApiError(String)
    
    static func == (lhs: ListRepositoriesState, rhs: ListRepositoriesState) -> Bool {
        switch (lhs, rhs) {
        case (.Init, .Init):
            return true
        case (.Loading, .Loading):
            return true
        case (.Success, .Success):
            return true
        case (.ApiError(let lhsError), .ApiError(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}

class ListRepositoriesViewModel: ObservableObject {
    
    @Published var uiState: ListRepositoriesState = .Init
    @Published var items: [RepositoryEntity] = []
    @Published var isLoadingMore: Bool = false
    @Published var errorWrapper: ErrorWrapper?
    
    private var currentPage = 1
    private var isPagination = false
    private let disposeBag = DisposeBag()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ListRepositories")
    
    let usecase: GetPopularRepositoriesUseCaseProtocol
    
    init(usecase: GetPopularRepositoriesUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func doRequestGetPopularRepositories(isPagination: Bool){
        if isPagination {
            self.isLoadingMore = true
        } else {
            self.uiState = .Loading
        }
        
        self.usecase.call(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] success in
                    if isPagination {
                        self?.isLoadingMore = false
                    } else {
                        self?.uiState = .Success
                    }
                    success.forEach { repo in
                        self?.items.appendIfNotContains(repo)
                    }
                    self?.monitor.cancel()
                    self?.currentPage += 1
                    debugPrint("\(String(describing: self?.items.count))")
                    debugPrint("\(String(describing: self?.currentPage))")
                }, onFailure: { [weak self] failure in
                    let err = failure as! NetworkError
                    self?.isLoadingMore = false
                    if isPagination {
                        self?.errorWrapper = ErrorWrapper(message: err.description)
                    } else {
                        if self?.items.isEmpty ?? false {
                            self?.uiState = .ApiError(err.description)
                        }
                    }
                    self?.startNetworkMonitor()
                }).disposed(by: disposeBag)
    }
    
    func clearError() {
        errorWrapper = nil
    }
    
    private func startNetworkMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied, self?.items.isEmpty ?? false {
                DispatchQueue.main.async {
                    self?.doRequestGetPopularRepositories(isPagination: false)
                }
            }
        }
        monitor.start(queue: queue)
    }
}
