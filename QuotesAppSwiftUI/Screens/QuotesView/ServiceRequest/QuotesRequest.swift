//
//  QuotesRequest.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

struct QuotesRequest: Router {
    
    typealias Response = QuotesData
    var method: HTTPMethod = .get
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.quotes.rawValue
}
