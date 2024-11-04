//
//  athleteViewModel.swift
//  straView
//
//  Created by Jonas Wangelin on 03.11.24.
//

import SwiftUI

class AthleteViewModel: NSObject, ObservableObject {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    func getAthlete() async {
            await authViewModel.createAthlete()
    }
}
