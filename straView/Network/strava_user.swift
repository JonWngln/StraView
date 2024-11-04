//
//  strava_user.swift
//  straView
//
//  Created by Jonas Wangelin on 02.11.24.
//

import Foundation

extension strava_connection {
  
  // MARK: Private Constants
  private static let accessTokenKey = "accessToken"
  private static let refreshTokenKey = "refreshToken"
  private static let expiresAtKey = "9999999999999999999999"
    
    static func saveTokenResponse(_ response: TokenResponse) {
        strava_connection.accessToken = response.accessToken
        strava_connection.refreshToken = response.refreshToken
        strava_connection.expiresAt = response.expiresAt
    }
    
    static func loadTokenResponse() -> TokenResponse? {
        guard let accessToken, let refreshToken, let expiresAt else { return nil }
        return TokenResponse(accessToken: accessToken, refreshToken: refreshToken, expiresAt: expiresAt)
    }
    
    static func removeTokenResponse() {
        strava_connection.accessToken = nil
        strava_connection.refreshToken = nil
        strava_connection.expiresAt = nil
    }

  // MARK: Properties
  static var accessToken: String? {
    get {
      UserDefaults.standard.string(forKey: accessTokenKey)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
    }
  }

  static var refreshToken: String? {
    get {
      UserDefaults.standard.string(forKey: refreshTokenKey)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: refreshTokenKey)
    }
  }
    static var expiresAt: Int? {
        get {
          UserDefaults.standard.integer(forKey: expiresAtKey)
        }
        set {
          UserDefaults.standard.setValue(newValue, forKey: expiresAtKey)
        }
    }
}
