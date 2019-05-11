//
//  GenericNetworkRouteScheme.swift
//  Netswift
//
//  Created by Dorian Grolaux on 03/04/2019.
//  Copyright © 2019 Skwiggs. All rights reserved.
//

import Foundation

/**
 A generic, all-purpose scheme provider.
 */
public enum GenericNetswiftRouteScheme {
    case http
    case https
    case ftp
}

extension GenericNetswiftRouteScheme: NetswiftRouteScheme {
    public var string: String {
        switch self {
        case .http:
            return "http://"
            
        case .https:
            return "https://"
            
        case .ftp:
            return "ftp://"
        }
    }
}
