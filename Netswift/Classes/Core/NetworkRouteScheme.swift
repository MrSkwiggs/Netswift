//
//  NetworkRouteScheme.swift
//  Network
//
//  Created by Dorian Grolaux on 10/10/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

/// Generic protocol to return URL Schemes as String
protocol NetworkRouteScheme {
    var string: String { get }
}
