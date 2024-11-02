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
    static var accessToken: String?
    
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
    
    static func codeExchange(code: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string: "https://www.strava.com/oauth/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)&grant_type=authorization_code"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "dataNilError", code: -1001, userInfo: nil)))
                return
            }
            do {
                print(data)
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                self.accessToken = tokenResponse.accessToken
                // Store the token in Keychain here
                
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
}
