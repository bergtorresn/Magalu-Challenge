//
//  ListViewModel.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import Foundation

enum ListPageState {
    case Init
    case Loading
    case SuccessfullyFetched([RepositoryEntity]) // List of matching Movies
    case NoResultsFound
    case ApiError(String) // Error message to be shown
}

class ListViewModel: ObservableObject {
    
    @Published var uiState: ListPageState = .Init
    
    let usecase: GetPopularRepositoriesUseCaseProtocol
    
    init(usecase: GetPopularRepositoriesUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func doRequestGetPopularRepositories(page: Int){
        self.uiState = .Loading

        self.usecase.call(page: page) { result in
            switch result {
            case .success(let success):
                if success.isEmpty {
                    self.uiState = .NoResultsFound
                } else {
                    self.uiState = .SuccessfullyFetched(success)
                }
            case .failure(let error):
                self.uiState = .ApiError(error.localizedDescription)
            }
        }            
    }
    
}
