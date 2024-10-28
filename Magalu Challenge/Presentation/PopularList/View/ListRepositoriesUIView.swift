//
//  ListRepositoriesUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import SwiftUI

struct ListRepositoriesUIView: View {
    
    @ObservedObject private var viewModel: ListRepositoriesViewModel
    
    init(viewModel: ListRepositoriesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                containedView()
            }
        }.onAppear(perform: {
            viewModel.doRequestGetPopularRepositories(isPagination: false)
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
                        ItemRepositoryUIView(item: item).onAppear(perform: {
                            if item == viewModel.items.last {
                                viewModel.doRequestGetPopularRepositories(isPagination: true)
                            }
                        })
                    }.listRowSpacing(20)
                }.navigationTitle(AppStrings.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .tint(.black))
            
        case .ApiError(let errorMessage):
            return AnyView(Text(errorMessage))
        }
    }
}

