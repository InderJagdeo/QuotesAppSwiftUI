//
//  TabView.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            QuoteView(viewModel: QuoteViewModel())
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            QuotesView()
                .tabItem {
                    Label("Quotes", systemImage: "quote.bubble")
                }
            
            AuthorsView()
                .tabItem {
                    Label("Authors", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
