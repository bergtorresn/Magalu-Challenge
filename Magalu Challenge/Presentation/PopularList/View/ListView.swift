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
            .navigationTitle("Our resturant")
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }.onAppear(perform: {
            viewModel.doRequestGetPopularRepositories(page: 1)
        })
        
    }
    
    func containedView() -> AnyView {
        switch viewModel.uiState {
            
        case .Init:
            return AnyView(EmptyView())
            
        case .Loading:
            return AnyView(Text("Loading"))
            
        case .SuccessfullyFetched(let items):
            return AnyView(
                NavigationView {
                    List(items) { item in
                        NavigationLink(destination: ItemDetailView(item: item)){
                            ItemView(item: item)
                            Spacer(minLength: 50)
                        }
                    }.listRowSpacing(10)
                        .listStyle(.plain)
                        .listRowBackground(Color.clear)
                }.navigationTitle("Hello World"))
            
        case .NoResultsFound:
            return AnyView(Text("No data found"))
            
        case .ApiError(let errorMessage):
            return AnyView(Text(errorMessage))
        }
    }
}

