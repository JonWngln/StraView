//
//  contentViewModel.swift
//  straView
//
//  Created by Jonas Wangelin on 02.11.24.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    func appeared() {
        if strava_connection.accessToken != nil {
            print("accessToken: ",  strava_connection.accessToken)
            self.isLoggedIn = true
        }
    }
}
