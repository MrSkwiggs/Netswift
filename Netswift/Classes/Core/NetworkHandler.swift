//
//  NetworkHandler.swift
//  Network
//
//  Created by Dorian Grolaux on 07/02/2019.
//  Copyright © 2019 Dorian Grolaux. All rights reserved.
//

import Foundation

/// Convenience alias for Network handlers
typealias NetworkHandler<Value> = (NetworkResult<Value, NetworkError>) -> Void
