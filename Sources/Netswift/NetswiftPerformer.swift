//
//  NetswiftPerformer.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Generic NetswiftRequest performer. For detailed doc please refer to NetswiftNetworkPerformer protocol
open class NetswiftPerformer: NetswiftNetworkPerformer {
    public let requestPerformer: HTTPPerformer
    
    public init(requestPerformer: HTTPPerformer = NetswiftHTTPPerformer()) {
        self.requestPerformer = requestPerformer
    }
    
    @discardableResult
    public func perform<Request: NetswiftRequest>(_ request: Request,
                                                deadline: DispatchTime? = nil,
                                                handler: @escaping NetswiftHandler<Request.Response>) -> NetswiftTask? {
        guard let deadline = deadline else {
            return perform(request, handler: handler)
        }
        switch request.serialise() {
        case .success(var url):
            hook(into: &url)
            return self.requestPerformer.perform(url, deadline: deadline) { response in
                handler(Self.validateResponse(response, from: request))
            }
            
        case .failure(let error):
            handler(.failure(error))
        }
        return nil
    }
    
    @discardableResult
    public func perform<Request: NetswiftRequest>(_ request: Request,
                                                handler: @escaping NetswiftHandler<Request.Response>) -> NetswiftTask? {
        switch request.serialise() {
        case .success(var url):
            hook(into: &url)
            return self.requestPerformer.perform(url) { response in
                handler(Self.validateResponse(response, from: request))
            }
            
        case .failure(let error):
            handler(.failure(error))
        }
        return nil
    }
    
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public func perform<Request: NetswiftRequest>(_ request: Request) async -> NetswiftResult<Request.Response> {
        switch request.serialise() {
        case .success(var url):
            hook(into: &url)
            return await Self.validateResponse(requestPerformer.perform(url),
                                          from: request)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public func perform<Request: NetswiftRequest>(_ request: Request) async throws -> Request.Response {
        switch request.serialise() {
        case .success(var url):
            hook(into: &url)
            let result = await Self.validateResponse(requestPerformer.perform(url),
                                                     from: request)
            switch result {
            case let .success(response): return response
            case let .failure(error): throw error
            }
        case .failure(let error):
            throw error
        }
    }
    
    /**
     Override this function to perform extra configuration on the outgoing URLRequest, before it is sent out.
     */
    open func hook(into urlRequest: inout URLRequest) {
        // overridable, empty default
    }
    
    private static func validateResponse<Request: NetswiftRequest>(_ result: NetswiftResult<Data?>,
                                                                   from request: Request) -> NetswiftResult<Request.Response> {
        switch result {
        case .success:
            return result
                .flatMap(request.decode)
                .flatMap(request.cast)
                .flatMap(request.deserialise)
            
        case .failure(let error):
            return request.intercept(error)
        }
    }
}
