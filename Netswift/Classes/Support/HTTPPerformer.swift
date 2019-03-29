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
    func perform (_ request: URLRequest, completion: @escaping (NetworkResult<Data?, NetworkError>) -> Void)
}
