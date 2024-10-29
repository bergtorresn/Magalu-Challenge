//
//  ListPullRequestsViewModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation

import RxSwift
import Network

enum ListPullRequestsState: Equatable {
    case Init
    case Loading
    case Success
    case ApiError(String)
    
    static func == (lhs: ListPullRequestsState, rhs: ListPullRequestsState) -> Bool {
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

class ListPullRequestsViewModel: ObservableObject {
    
    @Published var uiState: ListPullRequestsState = .Init
    @Published var items: [PullRequestEntity] = []

    let usecase: GetPullRequestsUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "PullRequests")
    private var lastOwnerNameUsed: String = ""
    private var lastRepositoryNameUsed: String = ""

    init(usecase: GetPullRequestsUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func doRequestGetPullRequestsUseCase(ownerName: String, repositoryName: String) {
        self.lastOwnerNameUsed = ownerName
        self.lastRepositoryNameUsed = repositoryName
        
        self.uiState = .Loading
        
        self.usecase.call(ownerName: ownerName, repositoryName: repositoryName)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] success in
                    success.forEach { pull in
                        self?.items.appendIfNotContains(pull)
                    }
                    self?.monitor.cancel()
                    self?.uiState = .Success
                }, onFailure: { [weak self] failure in
                    let err = failure as! NetworkError
                    self?.uiState = .ApiError(err.description)
                    self?.startNetworkMonitor()
                }).disposed(by: disposeBag)
    }
    
    private func startNetworkMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied, self?.items.isEmpty ?? false {
                DispatchQueue.main.async {
                    self?.doRequestGetPullRequestsUseCase(
                        ownerName: self?.lastOwnerNameUsed ?? "",
                        repositoryName: self?.lastRepositoryNameUsed ?? "")
                }
            }
        }
        monitor.start(queue: queue)
    }
}

