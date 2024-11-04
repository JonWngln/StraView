//
//  strava_connection.swift
//  straView
//
//  Created by Jonas Wangelin on 31.10.24.
//

import Foundation

class strava_connection {
    // static constant
    static let callbackURLScheme = "myapp"
    static let clientID = "79637"
    static let clientSecret = "53fe9651dc51e9b08f55a0aa9269235b0e8aad9d"
    static let redirect_uri = "myapp://myapp.com"
    static let scope = "read_all"
    
    static func createAuthorizationURL() -> URL? {
        var components = URLComponents(string: "https://www.strava.com/oauth/authorize")
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: strava_connection.clientID),
            URLQueryItem(name: "redirect_uri", value: strava_connection.redirect_uri),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: strava_connection.scope)
        ]
        return components?.url
    }
    
    static func codeExchange(code: String) async {
        let url = URL(string: "https://www.strava.com/oauth/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)&grant_type=authorization_code"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                    self.accessToken = tokenResponse.accessToken
                    // Need to make sure, that token is saved, before attempting to load Athlete
                    saveTokenResponse(tokenResponse)
                    print("token saved")
                } catch {
                    print("error: \(error)")
                }
            }
        }.resume()
    }
    
    static func codeRefresh() async {
        let url = URL(string: "https://www.strava.com/oauth/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "client_id=\(clientID)&client_secret=\(clientSecret)&grant_type=refresh_token&refresh_token=\(String(describing: refreshToken))"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                    self.accessToken = tokenResponse.accessToken
                    saveTokenResponse(tokenResponse)
                    print("token saved")
                } catch {
                    print("error: \(error)")
                }
            }
        }.resume()
        
    }
    
    static func getAthlete() async throws -> Athlete {
        print("getting Athlete")
        if isTokenExpired() {
            await codeRefresh()
        }
        let endpoint = "https://www.strava.com/api/v3/athlete"
        guard let url = URL(string: endpoint) else {
            throw StravaError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let tokenResponse = strava_connection.loadTokenResponse() else {
            throw StravaError.invalidToken
        }
        let accessToken = tokenResponse.accessToken
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw StravaError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let athlete = try decoder.decode(Athlete.self, from: data)
            return athlete
        } catch let decodingError{
            print("Decoding error: \(decodingError)")
            throw StravaError.invalidData
        }
    }
}

enum StravaError: Error {
    case invalidResponse
    case invalidData
    case invalidToken
    case invalidURL
}
