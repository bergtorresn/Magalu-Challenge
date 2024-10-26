//
//  Magalu_ChallengeApp.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres Nunes on 24/10/24.
//

import SwiftUI

@main
struct Magalu_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: 
                        ListViewModel(usecase:
                                        GetPopularRepositoriesUseCase(repository:
                                                                        PopularListRepository(dataSource: 
                                                                                                PopularListDataSource(networkService:
                                                                                                                        NetworkService())))))
        }
    }
}
