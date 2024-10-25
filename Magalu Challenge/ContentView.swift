//
//  ContentView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres Nunes on 24/10/24.
//

import SwiftUI

struct ContentView: View {
        
    private var usecase = GetPopularRepositoriesUseCase(repository:  PopularListRepository(dataSource: PopularListDataSource(networkService: NetworkService())))
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            usecase.call(page: 1) { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
