//
//  ContentView.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI

struct MainView: View {
    @State private var isSplashScreenVisible = true
    
    var body: some View {
        Group {
            if isSplashScreenVisible {
                SplashView()
                    .transition(.opacity)
            } else {
                MainTabView()
                    .networkStatusBar()
            }
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 4_000_000_000) // Delay for 4 seconds
                isSplashScreenVisible.toggle()
            }
            NetworkMonitor.shared.startMonitoring()
        }
    }
}

#Preview {
    MainView()
}
