//
//  SplashView.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text("Quotes")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Welcome to My App")
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
