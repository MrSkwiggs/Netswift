//
//  HTTPPerformer.swift
//  Netswift
//
//  Created by Dorian Grolaux on 03/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// An HTTP Performer works with low-level URLRequests and validates the response's status code
public protocol HTTPPerformer {
    /**
     Performs a standard URL request and returns the results via a completion handler
     - note: Potentially long wait times if something goes wrong.
     
     - parameter request: Any URLRequest that has already been initialised and configured.
     - parameter completion: A block that will be called when the data task eventually returns
     */
    func perform (_ request: URLRequest, completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask
    
    /**
     Performs a standard URL request and returns the results asynchronously
     - note: Potentially long wait times if something goes wrong.
     
     - parameter request: Any URLRequest that has already been initialised and configured.
     - returns: The Requests result
     */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func perform(_ request: URLRequest) async -> NetswiftResult<Data?>
    
    /**
     Performs a standard URL request and returns the results via a completionHandler
     - note: Always returns within defined time-out interval
     
     - parameter request: Any URLRequest that has already been initialised and configured.
     - parameter deadline: The maximum amount of seconds before the task is considered as timed-out, forcing a call to completion with a `.timedOut` NetswiftError.
     - parameter completion: A block that will be called when the data task eventually returns
     */
    func perform (_ request: URLRequest, deadline: DispatchTime, completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask
    
    /**
     Performs a standard URL request and returns the results asynchronously
     - note: Always returns within defined time-out interval
     
     - parameter request: Any URLRequest that has already been initialised and configured.
     - parameter deadline: The maximum amount of seconds before the task is considered as timed-out, forcing a call to completion with a `.timedOut` NetswiftError.
     - returns: The Requests result
     */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func perform(_ request: URLRequest, deadline: DispatchTime) async -> NetswiftResult<Data?>
}
