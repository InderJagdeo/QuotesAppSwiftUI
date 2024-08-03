//
//  AuthorDetail.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

struct AuthorDetail: Codable {
    
    let id, name: String
    let link: String
    let bio, description: String
    let quoteCount: Int
    let slug, dateAdded, dateModified: String
    let quotes: [Quote]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, link, bio, description, quoteCount, slug, dateAdded, dateModified, quotes
    }
}
