//
//  NetswiftRoute.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//
//  swiftlint:disable force_unwrapping

import Foundation

/**
 Protocol defining URL Routes for APIs.
 - important: URL components should strictly adhere to URLComponent formats; each component will be escaped accordingly, which might lead to erroneous generated URLs if formats are not respected.
 - important: This class uses some default implementation:
 - scheme: HTTPS by default
 - query: nil by default
 
 This allows for less verbose implementations of NetswiftRoutes
 */
public protocol NetswiftRoute {
    /**
     Which scheme to use
     - important: HTTPS by default
     */
    var scheme: NetswiftRouteScheme { get }
    
    /// The common host URL (eg. www.someurl.com)
    var host: String { get }
    
    /// The specific resource on the host (eg. get/some/resource.html)
    /// - important: Do not append aditional component delimiters (such as `/`). This is done when
    var path: String { get }
    
    /**
     An optional query (eg. `?byName=Dorian?limitResults=50`)
     - important: nil by default
     */
    var query: String? { get }
    
    /**
     A fully qualified URL
     
     - note: Uses the following format by default: `<scheme><host>/<path><query>`
     */
    var url: URL { get }
}

// MARK: - Default Functions

public extension NetswiftRoute {
    
    var scheme: NetswiftRouteScheme {
        get { return GenericNetswiftRouteScheme.https }
    }
    
    var query: String? {
        get { return nil }
    }
    
    
    var url: URL {
        let scheme = self.scheme.string
        let host = self.host.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let path = self.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let query = (self.query ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: "\(scheme)\(host)/\(path)\(query)")!
    }
}
