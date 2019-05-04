//
//  GenericNetworkRouteScheme.swift
//  OneFit
//
//  Created by Dorian Grolaux on 03/04/2019.
//  Copyright © 2019 OneFit. All rights reserved.
//

import Foundation

/**
 A generic, all-purpose network scheme provider.
 */
enum StandardNetworkRouteScheme {
    case http
    case https
    case ftp
}

extension StandardNetworkRouteScheme: NetworkRouteScheme {
    var string: String {
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
