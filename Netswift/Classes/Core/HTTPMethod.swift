//
//  HTTPMethod.swift
//  Netswift
//
//  Created by Dorian Grolaux on 29/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Standard HTTP methods
public enum HTTPMethod: String, CustomStringConvertible {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case options = "OPTIONS"
    case put = "PUT"
    case patch = "PATCH"
    
    var description: String {
        return self.rawValue
    }
}
