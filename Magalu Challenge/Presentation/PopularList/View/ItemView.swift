//
//  PopularListView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import SwiftUI

struct ItemView: View {
    let item: RepositoryEntity
    
    var body: some View {
        VStack(content: {
            HStack(content: {
                VStack(alignment: .leading, content: {
                    Text(item.name)
                        .font(.headline)
                        .lineLimit(nil)
                    Text(item.description)
                        .font(.subheadline)
                        .lineLimit(2)
                })
                Spacer()
                VStack(alignment: .center, content: {
                    Image(systemName: "sunglasses.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.purple, in: .circle)
                    Text(item.owner.name)
                        .font(.headline)
                        .lineLimit(nil)
                })
            })
            HStack(content: {
                HStack(content: {
                    Image(systemName: "sunglasses.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.purple, in: .circle)
                    Text("\(item.stargazersCount)")
                        .font(.body)
                        .lineLimit(1)
                })
                HStack(content: {
                    Image(systemName: "sunglasses.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.purple, in: .circle)
                    Text("\(item.watchersCount)")
                        .font(.body)
                        .lineLimit(1)
                })
                Spacer()
            })
            .padding(.vertical, 8)
        })
    }
}

