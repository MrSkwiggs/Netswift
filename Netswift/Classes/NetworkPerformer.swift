//
//  NetworkPerformer.swift
//  Network
//
//  Created by Dorian Grolaux on 29/06/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

/**
 A NetworkPerformer is the link between low-level url requests and high-level api requests
 */
protocol NetworkPerformer {
    
    /**
     Performs all the necessary work a NetworkRequest defines in order to generate a NetworkResult that either succeeds or fails.
     - parameter request: NetworkRequest of specific type
     - parameter handler: A completion block that takes in a NetworkResult that either contains a value of type NetworkRequest.Response or an error of type NetworkError
     */
    func perform<T: NetworkRequest>(_ request: T, handler: @escaping NetworkHandler<T.Response>)
}
