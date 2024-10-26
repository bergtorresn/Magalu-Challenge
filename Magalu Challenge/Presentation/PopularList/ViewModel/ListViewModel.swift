//
//  ListViewModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation
import RxSwift

enum ListPageState {
    case Init
    case Loading
    case SuccessfullyFetched([RepositoryEntity])
    case NoResultsFound
    case ApiError(String)
}

class ListViewModel: ObservableObject {
    
    @Published var uiState: ListPageState = .Init
    
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
                        self?.uiState = .NoResultsFound
                    } else {
                        self?.uiState = .SuccessfullyFetched(success)
                    }
                }, onFailure: { [weak self] failure in
                    self?.uiState = .ApiError(failure.localizedDescription)
                }).disposed(by: disposeBag)
    }
}
