//
//  NetswiftHandler.swift
//  Netswift
//
//  Created by Dorian Grolaux on 07/02/2019.
//  Copyright © 2019 Skwiggs. All rights reserved.
//

import Foundation

/// Convenience alias for Netswift handlers
public typealias NetswiftHandler<Value> = (NetswiftResult<Value, NetswiftError>) -> Void
