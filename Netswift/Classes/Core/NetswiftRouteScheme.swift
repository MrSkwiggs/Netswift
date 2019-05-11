//
//  NetswiftRouteScheme.swift
//  Netswift
//
//  Created by Dorian Grolaux on 10/10/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Generic protocol to return URL Schemes as String
public protocol NetswiftRouteScheme {
    var string: String { get }
}
