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
    case Success([PullRequestEntity])
    case ApiError(String)
    
    static func == (lhs: ListPullRequestsState, rhs: ListPullRequestsState) -> Bool {
        switch (lhs, rhs) {
        case (.Init, .Init):
            return true
        case (.Loading, .Loading):
            return true
        case (.Success(let lhsSuccess), .Success(let rhsSuccess)):
            return lhsSuccess == rhsSuccess
        case (.ApiError(let lhsError), .ApiError(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}

class ListPullRequestsViewModel: ObservableObject {
    
    @Published var uiState: ListPullRequestsState = .Init
    
    let usecase: GetPullRequestsUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    init(usecase: GetPullRequestsUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func doRequestGetPullRequestsUseCase(repository: RepositoryEntity){
        self.uiState = .Loading
        
        self.usecase.call(ownerName: repository.owner.name, repositoryName: repository.name)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] success in
                    if success.isEmpty {
                        self?.uiState = .Success([])
                    } else {
                        self?.uiState = .Success(success)
                    }
                }, onFailure: { [weak self] failure in
                    var errorMessage: String  = ""
                    let err = failure as! NetworkError
                    switch err {
                    case .decodeError(let d):
                        errorMessage = d
                    case .serverError(let s):
                        errorMessage = s
                    default:
                        errorMessage = AppStrings.unknownError
                    }
                    self?.uiState = .ApiError(errorMessage)
                }).disposed(by: disposeBag)
    }
}

