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
    let data: Data?
    var statusCode: Int {
        get {
            return (URLResponse as? HTTPURLResponse)?.statusCode ?? 500
        }
    }
    let URLResponse: URLResponse?
    let error: Swift.Error?

    init(data: Data?, response: URLResponse?, error: Swift.Error?) {
        self.data = data
        self.URLResponse = response
        self.error = error
    }
}
