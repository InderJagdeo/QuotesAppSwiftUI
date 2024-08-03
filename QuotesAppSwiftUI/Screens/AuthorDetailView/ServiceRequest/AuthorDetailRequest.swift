//
//  AuthorDetailRequest.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

struct AuthorDetailRequest: Router {
    
    typealias Response = AuthorDetail
    var method: HTTPMethod = .get
    var pathParameters: [String]
    var parameters: RequestParameters?
    var requestType: RequestType = .data
    var path: String = EndPoint.authors.rawValue
    
    init(id: String) {
        pathParameters = [id]
    }
}
