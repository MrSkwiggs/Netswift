//
//  NetworkResultResult.swift
//  Network
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

enum NetworkResult<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

extension NetworkResult {
    init(value: Value) {
        self = .success(value)
    }

    init(error: Error) {
        self = .failure(error)
    }
}

extension NetworkResult {
    /**
     Use this function when you need to process and validate a result in a chain against a given expected type `T`.

     If `self` is `.success`, the output will call the given completion check, which will return a new `NetworkResult`.
     That `NetworkResult` might succeed or fail, and will be of given type `T`.

     If `self` is `.failure`, the output will simply return a new `.failure` `NetworkResult` of given type `T`.

     This function is best used when multiple validation steps need to be taken on a `NetworkResult` object in an efficient manner.

     - parameter check: A function that takes in any value and returns a `NetworkResult` that adheres to given type `T`.
     - returns: A `NetworkResult` object of given type `T`
     */
    func check<T>(_ check: (Value) -> NetworkResult<T, Error>) -> NetworkResult<T, Error> {
        switch self {
        case let .success(data):
            return check(data)
        case let .failure(error):
            return .failure(error)
        }
    }
}

// MARK: - Convience providers

extension NetworkResult {

    /// Returns an object of Value type if there is one, nil otherwise
    var value: Value? {
        if case let .success(value) = self {
            return value
        }
        return nil
    }

    /// Returns an object of NetworkError type if there is one, nil otherwise
    var error: Error? {
        if case let .failure(error) = self {
            return error
        }
        return nil
    }
}
