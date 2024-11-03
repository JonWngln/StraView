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
        Text("Hello, Athlete!")
        
        Button("Get Athlete") {
            Task {
                await viewModel.getAthlete()
            }
        }
    }
}

#Preview {
    athleteView()
}
