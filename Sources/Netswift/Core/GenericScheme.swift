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
public enum GenericScheme: String {
    case http = "http://"
    case https = "https://"
    case ftp = "ftp://"
    case ldap = "ldap://"
    case mailto = "mailto:"
}
