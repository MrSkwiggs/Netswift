//
//  NetworkRoute.swift
//  Network
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//
//  swiftlint:disable force_unwrapping

import Foundation

/**
 Protocol defining URL Routes for APIs.
 - important: URL components should strictly adhere to URL component format; each component will be escaped accordingly, which might lead to erroneous generated URLs if formats are not respected.
 - important: This class uses some default implementation:
 - scheme: HTTPS by default
 - query: nil by default

 This allows for less verbose implementations of NetworkRoutes
 */
protocol NetworkRoute {
    /**
     Which scheme to use
     - important: HTTPS by default
     */
    var scheme: NetworkRouteScheme { get }

    /// The common base URL (eg. www.someurl.com)
    var host: String { get }

    /// The specific resource on the host (eg. /get/some/resource.html)
    var path: String { get }

    /**
     An optional additional request (eg. ?byName=Dorian?limitResults=50)
     - important: nil by default
     */
    var query: String? { get }
}

// MARK: - Default Functions

extension NetworkRoute {

    var scheme: NetworkRouteScheme {
        get { return StandardNetworkRouteScheme.https }
    }

    var query: String? {
        get { return nil }
    }

    /// Convenience method to get the full url generated from all members
    var url: URL {
        let scheme = self.scheme.string
        let host = self.host.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let path = self.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let query = (self.query ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: scheme + host + path + query)!
    }
}
