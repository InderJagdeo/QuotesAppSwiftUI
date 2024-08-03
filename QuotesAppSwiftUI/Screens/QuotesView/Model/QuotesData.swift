//
//  QuotesList.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

struct QuotesData: Codable {
    
    let count, totalCount, page, totalPages: Int
    let lastItemIndex: Int
    let results: [Quote]
}
