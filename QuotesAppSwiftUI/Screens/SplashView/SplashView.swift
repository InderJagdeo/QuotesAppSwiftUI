//
//  SplashView.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Quotes.")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Motivate Yourself With US!")
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
