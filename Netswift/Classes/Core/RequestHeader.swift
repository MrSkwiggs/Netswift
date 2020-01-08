//
//  RequestHeader.swift
//  Netswift
//
//  Created by Dorian Grolaux on 08/01/2020.
//

import Foundation

/**
 An HTTP Request header field. Defines its identifier & its value.
 */
public enum RequestHeader {
    /// Content-Type
    case contentType(MimeType)
    
    /// Accept
    case accept(MimeType)
    
    /// Authorization
    case authorization(NetswiftAuthorizationType)
    
    /// User-Agent
    case userAgent(String)
    
    /// A custom header field
    case custom(key: String, value: String)
    
    /// The name of this header field.
    public var key: String {
        switch self {
        case .accept: return "Accept"
        case .authorization: return "Authorizationn"
        case .contentType: return "Content-Type"
        case .userAgent: return "User-Agent"
        case .custom(let identifier, _): return identifier
        }
    }
    
    /// The value of this header field.
    public var value: String {
        switch self {
        case .accept(let type): return type.rawValue
        case .authorization(let secret): return secret.rawValue
        case .contentType(let type): return type.rawValue
        case .userAgent(let value): return value
        case .custom(_, let value): return value
        }
    }
}
