//
//  NetswiftResult.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

public typealias NetswiftResult<Success> = Result<Success, NetswiftError>

public extension NetswiftResult {
    init(value: Success) {
        self = .success(value)
    }

    init(error: Failure) {
        self = .failure(error)
    }
}

// MARK: - Convience providers

public extension NetswiftResult {

    /// Returns an object of Value type if there is one, nil otherwise
    var value: Success? {
        if case let .success(value) = self {
            return value
        }
        return nil
    }

    /// Returns an object of NetswiftError type if there is one, nil otherwise
    var error: Failure? {
        if case let .failure(error) = self {
            return error
        }
        return nil
    }
}
