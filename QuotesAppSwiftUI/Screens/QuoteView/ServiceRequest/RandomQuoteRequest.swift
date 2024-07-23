//
//  QuoteRequest.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

struct RandomQuoteRequest: Router {
    typealias Response = Quote
    var method: HTTPMethod = .get
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.randomQuote.rawValue
}
