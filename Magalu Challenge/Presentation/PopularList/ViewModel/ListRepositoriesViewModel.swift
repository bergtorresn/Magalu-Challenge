//
//  ListRepositoriesViewModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import RxSwift

enum ListRepositoriesState: Equatable {
    case Init
    case Loading
    case Success([RepositoryEntity])
    case ApiError(String)
    
    static func == (lhs: ListRepositoriesState, rhs: ListRepositoriesState) -> Bool {
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

class ListRepositoriesViewModel: ObservableObject {
    
    @Published var uiState: ListRepositoriesState = .Init
    
    let usecase: GetPopularRepositoriesUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    init(usecase: GetPopularRepositoriesUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func doRequestGetPopularRepositories(page: Int){
        self.uiState = .Loading
        
        self.usecase.call(page: page)
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
