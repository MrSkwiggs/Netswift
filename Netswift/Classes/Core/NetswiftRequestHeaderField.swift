//
//  NetswiftRequestHeaderField.swift
//  Netswift
//
//  Created by Dorian Grolaux on 08/01/2020.
//

import Foundation

/**
 An HTTP Request header field. Defines its identifier & its value.
 */
public enum NetswiftRequestHeaderField {
    /// Content-Type
    case contentType(type: NetswiftHTTPType)
    
    /// Accept
    case accept(type: NetswiftHTTPType)
    
    /// Authorization
    case authorization(secret: NetswiftAuthorizationType)
    
    /// A custom header field
    case custom(identifier: String, value: String)
    
    /// The name of this header field.
    var identifier: String {
        switch self {
        case .accept: return "Accept"
        case .authorization: return "Authorizationn"
        case .contentType: return "Content-Type"
        case .custom(let identifier, _): return identifier
        }
    }
    
    /// The value of this header field.
    var value: String {
        switch self {
        case .accept(let type): return type.rawValue
        case .authorization(let secret): return secret.rawValue
        case .contentType(let type): return type.rawValue
        case .custom(_, let value): return value
        }
    }
}
