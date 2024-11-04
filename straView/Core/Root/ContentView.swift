//
//  ContentView.swift
//  straView
//
//  Created by Jonas Wangelin on 30.10.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if authViewModel.currentAthlete != nil {
                athleteView()
            } else {
                signInView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthViewModel.example)
}
