//
//  athleteView.swift
//  straView
//
//  Created by Jonas Wangelin on 02.11.24.
//

import SwiftUI

struct athleteView: View {
    @ObservedObject private var viewModel = AthleteViewModel()
    
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                HStack {
                    Text(viewModel.currentAthlete!.firstname!)
                    Text(viewModel.currentAthlete!.lastname!)
                }
            }
            Text("Hello, Athlete!")
            
            Spacer()
            
            Button("Logout") {
                Task {
                    await viewModel.getAthlete()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getAthlete()
            }
        }
    }
}

#Preview {
    athleteView()
}
