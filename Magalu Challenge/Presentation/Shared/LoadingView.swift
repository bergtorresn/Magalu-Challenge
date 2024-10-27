//
//  LoadingView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20, content: {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2.0, anchor: .center)
            Text(AppStrings.stateLoading)
        })
    }
}
