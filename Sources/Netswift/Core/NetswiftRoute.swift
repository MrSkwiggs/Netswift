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
 
 This allows for less verbose implementations of NetswiftRoutes
 */
public protocol NetswiftRoute {
    /**
     Which scheme to use
     - note: HTTPS by default
     */
    var scheme: NetswiftScheme { get }
    
    /**
     The host
     
     Example: `google`
     */
    var host: String? { get }
    
    /**
     The port
     
     Example: `80`
     
     - note: `80` by default
     */
    var port: Int { get }
    
    /**
     The specific resource on the host
     
     Example: `/get/some/resource.html`
     */
    var path: String? { get }
    
    /**
     An optional query (eg. `?byName=Dorian?limitResults=50`)
     - important: nil by default
     */
    var query: String? { get }
    
    /**
     An optional fragment (eg. `#section3`)
     - important: nil by default
     - important: `#` is automatically added with default Netswift's url implementation
     */
    var fragment: String? { get }
    
    /**
     The type of HTTP method to use.
     - important: GET by default
     */
    var method: NetswiftHTTPMethod { get }
    
    /**
     A fully qualified URL
     
     - note: Uses the following format by default: `<scheme><host><port><path><query><fragment>`
     */
    var url: URL { get }
}

// MARK: - Default Implementations

public extension NetswiftRoute {
    
    var scheme: NetswiftScheme {
        return .https
    }
    
    var port: Int {
        return 80
    }
    
    var path: String? {
        return nil
    }
    
    var query: String? {
        return nil
    }
    
    var fragment: String? {
        return nil
    }
    
    var method: NetswiftHTTPMethod {
        return .get
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = self.scheme.value
        components.host = self.host
        components.port = self.port == 80 ? nil : self.port // Omit including port when it's 80
        components.path = self.path ?? "/"
        components.query = self.query
        components.fragment = self.fragment
        return components.url!
    }
}
