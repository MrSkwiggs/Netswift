//
//  URLRequestExtension.swift
//  Netswift
//
//  Created by Dorian Grolaux on 29/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Convenience wrapper functions
public extension URLRequest {
    mutating func setHTTPMethod(_ method: NetswiftHTTPMethod) {
        self.httpMethod = method.rawValue
    }
    
    mutating func setHeaders(_ headers: [RequestHeader]) {
        headers.forEach {
            setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
    
    mutating func addHeaders(_ headers: Set<RequestHeader>) {
        headers.forEach {
            addValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}
