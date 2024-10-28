//
//  ItemPullRequestUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import SwiftUI

struct ItemPullRequestUIView: View {
    let item: PullRequestEntity
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(item.title)
                .font(.headline)
                .lineLimit(nil)
            Text(item.body)
                .font(.subheadline)
                .lineLimit(3)
            HStack(content: {
                AsyncImage(url: URL(string: item.user.avatar)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .padding()
                        .frame(width: 32, height: 32)
                        .background(Color.gray.opacity(0.7))
                        .clipShape(Circle())
                }.frame(width: 32, height: 32)
                    .clipShape(Circle())
                VStack(content: {
                    Text(item.user.name)
                        .font(.headline)
                        .lineLimit(nil)
                })
            })
            Text(item.createdAt)
                .font(.caption)
                .lineLimit(nil)
        })
    }
}


