//
//  signInViewModel.swift
//  straView
//
//  Created by Jonas Wangelin on 02.11.24.
//

import AuthenticationServices
import SwiftUI

class SignInViewModel: NSObject, ObservableObject {
    
    func signInTapped() {
        guard let signInURL =
          strava_connection.createAuthorizationURL()
        else {
          print("Could not create the sign in URL .")
          return
        }
        let callbackURLScheme = strava_connection.callbackURLScheme
        let authenticationSession = ASWebAuthenticationSession(
          url: signInURL,
          callbackURLScheme: callbackURLScheme) { callbackURL, error in
          guard
            error == nil,
            let callbackURL = callbackURL,
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
            let code = queryItems.first(where: { $0.name == "code" })?.value
          else {
            print("An error occurred when attempting to sign in.")
            return
          }
              strava_connection.codeExchange(code: code) { result in
                  switch result {
                  case .success:
                      print("Authentication successful")
                  case .failure(let error):
                      print("Failed to authenticate: \(error)")
                  }
              }
              
        }
        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true
        authenticationSession.start()
    }
}

extension SignInViewModel: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession)
  -> ASPresentationAnchor {
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    return window ?? ASPresentationAnchor()
  }
}
