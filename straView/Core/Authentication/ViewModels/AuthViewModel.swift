//
//  AuthenticationViewModel.swift
//  straView
//
//  Created by Jonas Wangelin on 04.11.24.
//

import Foundation
import AuthenticationServices

@MainActor
class AuthViewModel: NSObject, ObservableObject {
    @Published var currentAthlete: Athlete?
    @Published var tokenResponse: TokenResponse?
    
    override init() {
        print("getting athlete")
        currentAthlete = CurrentAthlete.loadStoredAthlete()
        tokenResponse = strava_connection.loadTokenResponse()
    }
    
    //Preview init
    init(currentAthlete: Athlete?, tokenResponse: TokenResponse?) {
        self.currentAthlete = currentAthlete
        self.tokenResponse = tokenResponse
        super.init()
    }
    
    func signIn() {
        print("Sign in")
        startInitialAuthSession()
        //currentAthlete = Athlete.TEST_ATHLETE
    }
    
    func signOut() {
        print("Sign out")
        currentAthlete = nil
        CurrentAthlete.deleteStoredAthlete()
        tokenResponse = nil
        strava_connection.removeTokenResponse()
    }
    
    func startInitialAuthSession() {
        print("Start initial auth session")
        guard let signInURL = strava_connection.createAuthorizationURL()
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
            Task {
                await strava_connection.codeExchange(code: code)
                await self.createAthlete()
            }
            
      }
      authenticationSession.presentationContextProvider = self
      authenticationSession.prefersEphemeralWebBrowserSession = true
      authenticationSession.start()
    }
    
    func createAthlete() async {
        do {
            currentAthlete = try await strava_connection.getAthlete()
            CurrentAthlete.saveAthleteLocally(currentAthlete!)
        } catch {
            print("Failed to create athlete: \(error)")
        }
    }
}


extension AuthViewModel: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession)
  -> ASPresentationAnchor {
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    return window ?? ASPresentationAnchor()
  }
}

extension AuthViewModel: Observable {
    static var example: AuthViewModel = AuthViewModel(currentAthlete: Athlete.TEST_ATHLETE, tokenResponse: Athlete.TEST_ATHLETE.tokenResponse)
}
