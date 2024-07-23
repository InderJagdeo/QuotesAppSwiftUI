//
//  NetworkConstant.swift
//  NetworkLayer
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

public typealias StatusCode = Int
public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String : Any?]

var kTimeoutInterval: TimeInterval = 30.0
var kNetworkEnvironment: Environment = .development
var kRequestCachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData


