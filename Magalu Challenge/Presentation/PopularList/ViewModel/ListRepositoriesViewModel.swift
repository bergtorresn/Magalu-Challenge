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
    
    private var currentPage = 1
    
    let usecase: GetPopularRepositoriesUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    init(usecase: GetPopularRepositoriesUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func doRequestGetPopularRepositories(isPagination: Bool){
        if !isPagination {
            self.uiState = .Loading
        }
        
        self.usecase.call(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] success in
                    if !isPagination {
                        self?.uiState = .Success
                    }
                    self?.items.append(contentsOf: success)
                    self?.currentPage += 1
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