//
//  athleteView.swift
//  straView
//
//  Created by Jonas Wangelin on 02.11.24.
//

import SwiftUI

struct athleteView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if let athlete = authViewModel.currentAthlete {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                        VStack {
                            Text(athlete.firstname!)
                            Text(athlete.lastname!)
                        }
                    }
                }
                Section("General") {
                    HStack {
                        Text("Version")
                    }
                    
                }
                Section("Account") {
                    Button("Logout") {
                        Task {
                            authViewModel.signOut()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    athleteView()
}
