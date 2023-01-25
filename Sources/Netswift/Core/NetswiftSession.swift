//
//  NetswiftSession.swift
//  Netswift
//
//  Created by Declan McKenna on 05/05/2019.
//  Copyright © 2019 Skwiggs Inc. All rights reserved.
//

import Foundation

/// Protocol that allows to mock URLSessions
public protocol NetswiftSession {
    typealias RequestHandler = (NetswiftHTTPResponse) -> Void
    
    func perform(_ urlRequest: URLRequest, handler: @escaping RequestHandler) -> NetswiftTask

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func perform(_ urlRequest: URLRequest) async -> NetswiftHTTPResponse
}

/// Extension to make URLSession compliant with NetswiftSession
extension URLSession: NetswiftSession {
    
    ///DataTask call made via NetswiftSession Protocol
    public func perform(_ urlRequest: URLRequest, handler: @escaping RequestHandler) -> NetswiftTask {
        let task = dataTask(with: urlRequest) { data, response, error in
            handler(.init(data: data, response: response, error: error))
        }
        task.resume()
        
        return task
    }

    /// Asynchronous data call made via NetswiftSession Protocol
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public func perform(_ urlRequest: URLRequest) async -> NetswiftHTTPResponse {
        do {
            let (data, response) = try await data(for: urlRequest)
            return NetswiftHTTPResponse(data: data, response: response, error: nil)
        } catch {
            return NetswiftHTTPResponse(data: nil, response: nil, error: error)
        }
    }
}
