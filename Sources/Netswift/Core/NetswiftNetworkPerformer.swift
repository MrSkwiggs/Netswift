//
//  NetswiftNetworkPerformer.swift
//  Netswift
//
//  Created by Dorian Grolaux on 29/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/**
 A `NetswiftNetworkPerformer` is the link between low-level url requests and high-level api requests
 */
public protocol NetswiftNetworkPerformer {
    
    /**
     Performs all the necessary work a NetswiftRequest defines in order to generate a `NetswiftResult` that either succeeds or fails.
     - parameter request: `NetswiftRequest` of specific type
     - parameter handler: A completion block that takes in a `NetswiftResult` that either contains a value of type `NetswiftRequest.Response` or an error of type `NetswiftError`
     - returns: An optional `NetswiftTask` which can be used for further management of the ongoing request.
     */
    func perform<Request: NetswiftRequest>(_ request: Request,
                                           deadline: DispatchTime?,
                                           handler: @escaping NetswiftHandler<Request.Response>) -> NetswiftTask?

    /**
     Performs all the necessary work a NetswiftRequest defines in order to generate a `NetswiftResult` that either succeeds or fails.
     - parameter request: `NetswiftRequest` of specific type
     - returns: An asynchronous `NetswiftResult` with the type specified within the `NetswiftRequest` argument.
     */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func perform<Request: NetswiftRequest>(_ request: Request) async -> NetswiftResult<Request.Response>
    
    /**
     Performs all the necessary work a NetswiftRequest defines in order to generate a `NetswiftResult` that either succeeds or fails.
     - parameter request: `NetswiftRequest` of specific type
     - throws: Any networking-related error.
     - returns: An asynchronous `Response` type.
     */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func perform<Request: NetswiftRequest>(_ request: Request) async throws -> Request.Response
}
