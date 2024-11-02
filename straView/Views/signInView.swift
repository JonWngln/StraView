//
//  signInView.swift
//  straView
//
//  Created by Jonas Wangelin on 31.10.24.
//

import SwiftUI

struct signInView: View {
    @ObservedObject private var viewModel = SignInViewModel()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: 150)
                    .cornerRadius(10)
                Spacer()
                    .frame(height: 200)
                Button(action: { viewModel.signInTapped() } ) {
                    Text("Sign in with Strava")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
        }
    }
}

#Preview {
    signInView()
}
