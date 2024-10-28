//
//  ListPullRequestsUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import SwiftUI

struct ListPullRequestsUIView: View {
    let repository: RepositoryEntity
    
    @ObservedObject private var viewModel: ListPullRequestsViewModel
    
    init(repository: RepositoryEntity) {
        self.repository = repository
        self.viewModel = DependecyInjector.shared.resolve(ListPullRequestsViewModel.self)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                containedView()
            }
        }.onAppear(perform: {
            viewModel.doRequestGetPullRequestsUseCase(ownerName: repository.owner.name, repositoryName: repository.name)
        })
    }
    
    func containedView() -> AnyView {
        switch viewModel.uiState {
            
        case .Init:
            return AnyView(EmptyView())
            
        case .Loading:
            return AnyView(LoadingView())
            
        case .Success:
            return AnyView(
                NavigationView {
                    List(viewModel.items) { item in
                        ItemPullRequestUIView(item: item)
                    }.listRowSpacing(20)
                }.navigationTitle(repository.name))
            
        case .ApiError(let errorMessage):
            return AnyView(Text(errorMessage))
        }
    }
}
