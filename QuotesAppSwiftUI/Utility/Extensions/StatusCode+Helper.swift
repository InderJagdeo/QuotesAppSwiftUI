//
//  StatusCode+Helper.swift
//  NetworkLayer
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation

extension StatusCode {
    var isSuccess: Bool {
        (200..<300).contains(self)
    }
}
