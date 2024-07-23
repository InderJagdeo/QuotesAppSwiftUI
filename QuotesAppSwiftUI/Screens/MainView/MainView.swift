//
//  ContentView.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI

struct MainView: View {
    @State private var showSplashScreen = true
    
    var body: some View {
        Group {
            if showSplashScreen {
                SplashView()
                    .transition(.opacity)
            } else {
                MainTabView()
            }
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 4_000_000_000) // Delay for 4 seconds
                showSplashScreen.toggle()
            }
        }
    }
}

#Preview {
    MainView()
}
