//
//  ListRepositoriesUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import SwiftUI

struct ListRepositoriesUIView: View {
    
    @ObservedObject private var viewModel: ListRepositoriesViewModel
    
    init() {
        self.viewModel = DependecyInjector.shared.resolve(ListRepositoriesViewModel.self)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                containedView()
            }
            .navigationTitle(AppStrings.navigationTitle)
            .navigationBarTitleDisplayMode(.automatic)
            .font(.system(.title))
            .onViewDidLoad {
                viewModel.doRequestGetPopularRepositories(
                    isPagination: false)
            }.alert(item: $viewModel.errorWrapper) { error in
                Alert(
                    title: Text(AppStrings.dialogTitleDefault),
                    message: Text(error.message),
                    dismissButton: .default(Text(AppStrings.dialogBtnOk)) {
                        viewModel.clearError()
                    }
                )
            }
        }
    }
    
    func containedView() -> AnyView {
        switch viewModel.uiState {
            
        case .Init:
            return AnyView(EmptyView())
            
        case .Loading:
            return AnyView(LoadingView())
            
        case .Success:
            return AnyView(
                List(viewModel.items) { item in
                    ItemRepositoryUIView(item: item).accessibilityIdentifier("GitHubRepository")
                        .onAppear {
                            if item == viewModel.items.last {
                                viewModel.doRequestGetPopularRepositories(
                                    isPagination: true)
                            }
                        }
                }.overlay {
                    if viewModel.isLoadingMore {
                        LoadingView()
                    }
                }.listRowSpacing(20)
                    .listStyle(.plain)
            )
            
        case .ApiError(let errorMessage):
            return AnyView(Text(errorMessage))
        }
    }
}

