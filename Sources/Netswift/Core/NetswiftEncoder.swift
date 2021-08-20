//
//  NetswiftEncoder.swift
//  Netswift
//
//  Created by Dorian Grolaux on 20/08/2021.
//

import Foundation

/**
 A convenience wrapper for common encoders
 */
public protocol NetswiftEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: NetswiftEncoder {}
extension PropertyListEncoder: NetswiftEncoder {}
