//
//  Quote.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

struct Quote: Identifiable, Codable, Hashable {
    
    let id, content, author, dateAdded: String
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case content, author, dateAdded
    }
}
