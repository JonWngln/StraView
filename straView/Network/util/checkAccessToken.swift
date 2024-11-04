//
//  checkAccessToken.swift
//  straView
//
//  Created by Jonas Wangelin on 03.11.24.
//

import Foundation

extension strava_connection {
    
    static func isTokenExpired() -> Bool {
        guard let tokenResponse = strava_connection.loadTokenResponse() else { return false }
        
        let secondsStamp = Int(Date().timeIntervalSince1970)
        print("\(secondsStamp)")
        print("\(tokenResponse.expiresAt)")
        
        return tokenResponse.expiresAt < secondsStamp
    }
    
}

