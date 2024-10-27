//
//  PopularListTableView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject private var viewModel: ListViewModel
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                containedView()
            }
        }.onAppear(perform: {
            viewModel.doRequestGetPopularRepositories(page: 1)
        })
        
    }
    
    func containedView() -> AnyView {
        switch viewModel.uiState {
            
        case .Init:
            return AnyView(EmptyView())
            
        case .Loading:
            return AnyView(LoadingView())
            
        case .Success(let items):
            return AnyView(
                NavigationView {
                    List(items) { item in
                        NavigationLink(destination: ItemDetailsUIView(repository: item, viewModel: ItemDetailViewModel(usecase: GetPullRequestsUseCase(repository: PullRequestsRepository(dataSource: PullRequestsDatasource(networkService: NetworkService()))))).toolbarRole(.editor)){
                            ItemView(item: item)
                            Spacer(minLength: 50)
                        }
                    }.listRowSpacing(10)
                        .listStyle(.plain)
                        .listRowBackground(Color.clear)
                }.navigationTitle(AppStrings.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .tint(.black))
            
        case .ApiError(let errorMessage):
            return AnyView(Text(errorMessage))
        }
    }
}

