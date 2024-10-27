//
//  ItemDetailView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import SwiftUI

struct ItemDetailsUIView: View {
    let repository: RepositoryEntity

    @ObservedObject private var viewModel: ItemDetailViewModel
    
    init(repository: RepositoryEntity, 
         viewModel: ItemDetailViewModel) {
        self.repository = repository
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                containedView()
            }
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }.onAppear(perform: {
            viewModel.doRequestGetPullRequestsUseCase(repository: repository)
        })
        
    }
    
    func containedView() -> AnyView {
        switch viewModel.uiState {
            
        case .Init:
            return AnyView(EmptyView())
            
        case .Loading:
            return AnyView(Text("Loading"))
            
        case .Success(let items):
            return AnyView(
                NavigationView {
                    List(items) { item in
                        NavigationLink(destination: WebViewUIView(repositoryURL: item.url)){
                            PullRequestItemUIView(item: item)
                            Spacer(minLength: 50)
                        }
                    }.listRowSpacing(10)
                        .listStyle(.plain)
                        .listRowBackground(Color.clear)
                }.navigationTitle(repository.name))
            
        case .ApiError(let errorMessage):
            return AnyView(Text(errorMessage))
        }
    }
}
