//
//  LoadingView.swift
//  Magalu Challenge
//
//  Created by Rosemberg Torres on 27/10/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(content: {
            ProgressView(AppStrings.stateLoading)
                .font(.system(size:14))
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2.0, anchor: .center)
        }).frame(width: 130, height: 120, alignment: .center).background(Color.white).cornerRadius(20)
    }
}
#Preview {
    LoadingView()
}
