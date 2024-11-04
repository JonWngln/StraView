//
//  ContentView.swift
//  straView
//
//  Created by Jonas Wangelin on 30.10.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewmodel = ContentViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if authViewModel.currentAthlete != nil {
                athleteView()
            } else {
                signInView()
            }
        }
        .onAppear {
            viewmodel.appeared()
        }
    }
}

#Preview {
    ContentView()
}
