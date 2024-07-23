//
//  Data+Ext.swift
//  ListView
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation


extension Data {
    // MARK: - Data
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
