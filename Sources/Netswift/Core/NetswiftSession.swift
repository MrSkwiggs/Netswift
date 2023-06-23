//
//  NetswiftSession.swift
//  Netswift
//
//  Created by Declan McKenna on 05/05/2019.
//  Copyright © 2019 Skwiggs Inc. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Protocol that allows to mock URLSessions
public protocol NetswiftSession {
    typealias RequestHandler = (NetswiftHTTPResponse) -> Void
    
    func perform(_ urlRequest: URLRequest, handler: @escaping RequestHandler) -> NetswiftTask

    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
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
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public func perform(_ urlRequest: URLRequest) async -> NetswiftHTTPResponse {
        do {
            let (data, response) = try await data(for: urlRequest)
            return NetswiftHTTPResponse(data: data, response: response)
        } catch {
            return NetswiftHTTPResponse(data: nil, response: nil, error: error)
        }
    }
}
