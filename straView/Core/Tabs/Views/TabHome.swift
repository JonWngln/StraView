//
//  TabView.swift
//  straView
//
//  Created by Jonas Wangelin on 04.11.24.
//

import SwiftUI

struct TabHome: View {
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Stats")
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Stats") }
            Text("Routes")
                .tabItem {
                    Image(systemName: "arrow.triangle.swap")
                    Text("Routes") }
            Text("Segments")
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Segments")
                }
            athleteView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Athlete") }
        }
        .accentColor(.orange)
    }
}

#Preview {
    TabHome()
        .environment(AuthViewModel.example)
}
