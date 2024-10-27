//
//  PullRequestItemUIView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import SwiftUI

struct PullRequestItemUIView: View {
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
                Image(systemName: "sunglasses.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.purple, in: .circle)
                VStack(content: {
                    Text(item.user.name)
                        .font(.headline)
                        .lineLimit(nil)
                })
            })
            Text(item.createdAt)
                .font(.body)
                .lineLimit(nil)
        })
    }
}


