//
//  HTTPMethod.swift
//  Netswift
//
//  Created by Dorian Grolaux on 29/06/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

/// Standard HTTP methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case options = "OPTIONS"
    case put = "PUT"
    case patch = "PATCH"
}
