//
//  NetswiftRequestPerformable.swift
//  Netswift
//
//  Created by Dorian Grolaux on 03/05/2019.
//  Copyright © 2019 Skwiggs. All rights reserved.
//

import Foundation

/// Convenience protocol for allowing NetswiftRequests to be called directly
public protocol NetswiftRequestPerformable: NetswiftRequest {
    
    /**
     Performs the request with its own, self-defined NetswiftNetworkPerformer
     - parameter handler: Called when the request returns
     - returns: An optional `NetswiftTask` which can be used for further management of the ongoing request.
     */
    func perform(_ handler: @escaping NetswiftHandler<Self.Response>) -> NetswiftTask?
    
    /**
     Performs the request with its own, self-defined NetworkPerformer, with a deadline.
     - parameters:
        - handler: Called when the request returns
        - deadline: Amount of time before the request is considered as having timed-out.
     - returns: An optional `NetswiftTask` which can be used for further management of the ongoing request.
     */
    func perform(deadline: DispatchTime, _ handler: @escaping NetswiftHandler<Self.Response>) -> NetswiftTask?
    
    /**
     Performs the request with its own, self-defined NetswiftNetworkPerformer, asynchronously.
     - returns: The result of this request, either a failure with an error, or a success with an instance of type `Self.Response`.
     */
    @available(iOS 15, *)
    func perform() async -> NetswiftResult<Self.Response>
}
