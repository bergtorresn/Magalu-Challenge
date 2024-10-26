//
//  ItemDetailView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 25/10/24.
//

import SwiftUI

struct ItemDetailView: View {
    let item: RepositoryEntity

    var body: some View {
        Text(item.name).navigationTitle(item.name)
    }
}
