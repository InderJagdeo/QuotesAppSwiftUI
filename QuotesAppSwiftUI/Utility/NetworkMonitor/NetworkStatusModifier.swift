//
//  NetworkStatusModifier.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 27/07/24.
//

import Foundation
import SwiftUI

struct NetworkStatusModifier: ViewModifier {
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    @State private var isShowStatusBar: Bool = false
    
    private let duration: TimeInterval = 3.0
    
    func body(content: Content) -> some View {
        ZStack {
            content
            networkContent
        }
        .onReceive(networkMonitor.$isConnectd) { _ in
            withAnimation {
                self.isShowStatusBar = true
            }
        }
    }
}

private extension NetworkStatusModifier {
    @ViewBuilder
    var networkContent: some View {
        VStack {
            if isShowStatusBar {
                NetworkView(isConnectd: networkMonitor.isConnectd, duration: duration, isShowStatusBar: $isShowStatusBar)
            }
            Spacer()
        }
    }
}

private extension NetworkStatusModifier  {
    struct NetworkView: View {
        var isConnectd: Bool
        var duration: Double
        @Binding var isShowStatusBar: Bool
        
        var body: some View {
            HStack {
                Label(isConnectd ? "You are online." : "You are offline.", systemImage: isConnectd ? "wifi" : "wifi.slash")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(isConnectd ? Color.green  : Color.red)
                
            }
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.easeInOut(duration: 0.3), value: isShowStatusBar)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation {
                        self.isShowStatusBar = false
                    }
                }
            }
        }
    }
}

extension View {
    func networkStatusBar() -> some View {
        self.modifier(NetworkStatusModifier())
    }
}
