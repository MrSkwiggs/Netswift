//
//  NetworkRequestParameterRepresentable.swift
//  Netswift
//
//  Created by Dorian Grolaux on 04/05/2019.
//  Copyright © 2019 Skwiggs Inc. All rights reserved.
//

import Foundation

/// A convenience protocol which can be used by custom Request Parameter types
protocol NetworkRequestParameterRepresentable {
    var networkRequestParameter: NetworkRequestParameter? { get }
}
