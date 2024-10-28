//
//  ListPullRequestsViewModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import Foundation

import RxSwift

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
    
    init(usecase: GetPullRequestsUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func doRequestGetPullRequestsUseCase(ownerName: String, repositoryName: String) {
        self.uiState = .Loading
        
        self.usecase.call(ownerName: ownerName, repositoryName: repositoryName)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] success in
                    self?.items.append(contentsOf: success)
                    self?.uiState = .Success
                }, onFailure: { [weak self] failure in
                    let err = failure as! NetworkError
                    self?.uiState = .ApiError(err.description)
                }).disposed(by: disposeBag)
    }
}

