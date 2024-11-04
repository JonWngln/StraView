//
//  athleteViewModel.swift
//  straView
//
//  Created by Jonas Wangelin on 03.11.24.
//

import SwiftUI

class AthleteViewModel: NSObject, ObservableObject {
    
    func getAthlete() async {
        do {
            let currentAthlete = try await strava_connection.getAthlete()
            print(currentAthlete)
        } catch {
            print ("Error: \(error)")
        }
    }
}
