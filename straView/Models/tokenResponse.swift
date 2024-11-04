//
//  tokenResponse.swift
//  straView
//
//  Created by Jonas Wangelin on 02.11.24.
//

struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
    }
    
    
}
