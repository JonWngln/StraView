//
//  straViewApp.swift
//  straView
//
//  Created by Jonas Wangelin on 30.10.24.
//

import SwiftUI

@main
struct straViewApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
