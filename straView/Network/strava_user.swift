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
  private static let firstNameKey = "username"
  private static let identKey = "01"
  private static let expiresAtKey = "9999999999999999999999"

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

  static var firstname: String? {
    get {
      UserDefaults.standard.string(forKey: firstNameKey)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: firstNameKey)
    }
  }
  static var ident: Int? {
      get {
        UserDefaults.standard.integer(forKey: identKey)
      }
      set {
        UserDefaults.standard.setValue(newValue, forKey: identKey)
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
