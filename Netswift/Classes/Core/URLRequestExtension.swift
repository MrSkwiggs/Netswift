//
//  URLRequestExtension.swift
//  Microservices
//
//  Created by Dorian Grolaux on 29/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Convenience wrapper functions
public extension URLRequest {

    /// Adds an Authorization header with given bearer token
    mutating func authenticate(withBearer token: String) {
        self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

    mutating func setHTTPMethod(_ method: NetswiftHTTPMethod) {
        self.httpMethod = method.rawValue
    }

    mutating func setHTTPTypes(_ types: Set<NetswiftHTTPType>) {
        for type in types {
            setHTTPType(type)
        }
    }

    mutating func setHeaders(_ headers: [String: String]) {
        for header in headers {
            self.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }

    mutating func setHTTPType(_ type: NetswiftHTTPType) {
        guard !(self.allHTTPHeaderFields?.contains(where: { return $0.key == "Content-Type" && $0.value == type.rawValue }) ?? false) else {
            return
        }
        self.setValue(type.rawValue, forHTTPHeaderField: "Content-Type")
    }
}
