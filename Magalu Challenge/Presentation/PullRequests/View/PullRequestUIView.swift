//
//  PullRequestWVUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 29/10/24.
//

import SwiftUI

struct PullRequestUIView: View {
    
    @ObservedObject var viewModel: WebViewViewModel
    
    init(repositoryURL: String) {
        self.viewModel = DependecyInjector.shared.resolveWithArgs(WebViewViewModel.self, argument: repositoryURL)
    }
    
    var body: some View {
        PullRequestWebViewUIView(viewModel: viewModel).overlay {
            if viewModel.isLoading {
                LoadingView()
            }
        }.ignoresSafeArea()
            .alert(item: $viewModel.errorWrapper) { error in
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
