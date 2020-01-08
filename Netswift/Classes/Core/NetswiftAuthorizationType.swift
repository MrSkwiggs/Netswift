//
//  NetswiftAuthorizationType.swift
//  Netswift
//
//  Created by Dorian Grolaux on 08/01/2020.
//

import Foundation

/**
 An Authorization HTTP Request header field.
 */
public enum NetswiftAuthorizationType {
    
    /// Bearer \<token\>
    case bearer(token: String)
    
    var rawValue: String {
        switch self {
        case .bearer(let token):
            return "Bearer \(token)"
        }
    }
}
