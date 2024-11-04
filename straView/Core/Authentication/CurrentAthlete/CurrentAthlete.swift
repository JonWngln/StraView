//
//  currentAthlete.swift
//  straView
//
//  Created by Jonas Wangelin on 04.11.24.
//
import Foundation

class CurrentAthlete {
    static func saveAthleteLocally(_ athlete: Athlete) {
        do {
            let data = try JSONEncoder().encode(athlete)
            UserDefaults.standard.set(data, forKey: "storedAthlete")
            print("saved Athlete")
        } catch {
            print("Failed to save athlete:", error)
        }
    }
    
     static func loadStoredAthlete() -> Athlete? {
        guard let data = UserDefaults.standard.data(forKey: "storedAthlete") else {
            return nil
        }
        do {
            let athlete = try JSONDecoder().decode(Athlete.self, from: data)
            print("loaded Athlete")
            return athlete
        } catch {
            print("Failed to load athlete:", error)
            return nil
        }
    }
    
    static func deleteStoredAthlete() {
        UserDefaults.standard.removeObject(forKey: "storedAthlete")
    }
}
