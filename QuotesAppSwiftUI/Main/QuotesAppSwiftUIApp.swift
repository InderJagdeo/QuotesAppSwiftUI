//
//  QuotesAppSwiftUIApp.swift
//  QuotesAppSwiftUI
//
//  Created by SDNA Tech on 21/07/24.
//

import SwiftUI
import SwiftData

@main
struct QuotesAppSwiftUIApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
                .networkStatusBar()
        }
        .modelContainer(sharedModelContainer)
    }
}
