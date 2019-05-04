//
//  HTTPPerformer.swift
//  Netswift
//
//  Created by Dorian Grolaux on 03/07/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

/// An HTTP Performer works with low-level URLRequests and validates the response's status code
protocol HTTPPerformer {
    /**
     Performs a standard URL request and returns the results.
     - note: Potentially long wait times if something goes wrong.
     
     - parameter request: Any URLRequest that has already been initialised and configured.
     - parameter completion: A block that will be called when the data task eventually returns
    */
    func perform (_ request: URLRequest, completion: @escaping (NetworkResult<Data?, NetworkError>) -> Void)
    
    /**
     Performs a standard URL request and returns the results.
     - note: Always returns within defined time-out interval
     
     - parameter request: Any URLRequest that has already been initialised and configured.
     - parameter timeOut: The maximum amount of seconds before the task is considered as timed-out, forcing a call to completion with a `.timedOut` network error.
     - parameter completion: A block that will be called when the data task eventually returns
     */
    func perform (_ request: URLRequest, waitUpTo timeOut: DispatchTime, completion: @escaping (NetworkResult<Data?, NetworkError>) -> Void)
}
