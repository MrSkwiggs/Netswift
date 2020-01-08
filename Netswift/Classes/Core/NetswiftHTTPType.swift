//
//  NetswiftHTTPType.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Standard and custom HTTP Types
public enum NetswiftHTTPType: Hashable {
    case json
    case custom(type: String)
    
    var rawValue: String {
        switch self {
        case .custom(let type): return type
        case .json: return "application/json"
        }
    }
}
