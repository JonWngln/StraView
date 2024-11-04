//
//  signInView.swift
//  straView
//
//  Created by Jonas Wangelin on 31.10.24.
//

import SwiftUI

struct signInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                Spacer()
                    .frame(height: 200)
                Button("Sign in with Strava") {
                    Task {
                        authViewModel.signIn()
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    signInView()
}
