//
//  AuthrosRequest.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

struct AuthorsRequest: Router {
    
    typealias Response = AuthorsData
    var method: HTTPMethod = .get
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.authors.rawValue
}
