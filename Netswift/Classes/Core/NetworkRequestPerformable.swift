//
//  NetworkRequestPerformable.swift
//  OneFit
//
//  Created by Dorian Grolaux on 03/05/2019.
//  Copyright © 2019 OneFit. All rights reserved.
//

import Foundation

/// Convenience protocol for allowing NetworkRequests to be called directly
protocol NetworkRequestPerformable: NetworkRequest {
    
    /**
     Performs the request with its own, self-defined NetworkPerformer
     - parameter handler: Called when the request returns
     */
    func perform(_ handler: @escaping NetworkHandler<Self.Response>)
}
