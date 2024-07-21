//
//  Item.swift
//  QuotesAppSwiftUI
//
//  Created by SDNA Tech on 21/07/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
