//
//  NetswiftHTTPResponse.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Convenience wrapper for URLResponses
public struct NetswiftHTTPResponse {
    public let data: Data?
    public var statusCode: Int? {
        return (URLResponse as? HTTPURLResponse)?.statusCode
    }
    public let URLResponse: URLResponse?
    public let error: Swift.Error?

    public  init(data: Data?, response: URLResponse?, error: Swift.Error?) {
        self.data = data
        self.URLResponse = response
        self.error = error
    }
}
