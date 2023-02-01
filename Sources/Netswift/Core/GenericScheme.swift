//
//  GenericScheme.swift
//  Netswift
//
//  Created by Dorian Grolaux on 03/04/2019.
//  Copyright © 2019 Skwiggs. All rights reserved.
//

import Foundation

/**
 A generic, all-purpose scheme provider.
 */
public enum NetswiftScheme {
    
    case http
    case https
    case ftp
    case ldap
    case mailto
    case custom(scheme: String)
    
    public var value: String {
        switch self {
        case .http:
            return "http"
        case .https:
            return "https"
        case .ftp:
            return "ftp"
        case .ldap:
            return "ldap"
        case .mailto:
            return "mailto"
        case .custom(let scheme):
            return scheme
        }
    }
}
