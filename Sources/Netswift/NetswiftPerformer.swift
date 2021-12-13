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
    let requestPerformer: HTTPPerformer
    
    public init(requestPerformer: HTTPPerformer = NetswiftHTTPPerformer()) {
        self.requestPerformer = requestPerformer
    }
    
    @discardableResult
    open func perform<Request: NetswiftRequest>(_ request: Request,
                                                deadline: DispatchTime? = nil,
                                                handler: @escaping NetswiftHandler<Request.Response>) -> NetswiftTask? {
        guard let deadline = deadline else {
            return perform(request, handler: handler)
        }
        switch request.serialise() {
        case .success(let url):
            return self.requestPerformer.perform(url, waitUpTo: deadline) { response in
                handler(Self.validateResponse(response, from: request))
            }
            
        case .failure(let error):
            handler(.failure(error))
        }
        return nil
    }
    
    @discardableResult
    open func perform<Request: NetswiftRequest>(_ request: Request,
                                                   handler: @escaping NetswiftHandler<Request.Response>) -> NetswiftTask? {
        switch request.serialise() {
        case .success(let url):
            return self.requestPerformer.perform(url) { response in
                handler(Self.validateResponse(response, from: request))
            }
            
        case .failure(let error):
            handler(.failure(error))
        }
        return nil
    }
    
    @available(iOS 15, *)
    open func perform<T: NetswiftRequest>(_ request: T) async -> NetswiftResult<T.Response> {
        switch request.serialise() {
        case .success(let url):
            return await Self.validateResponse(requestPerformer.perform(url),
                                          from: request)
        case .failure(let error):
            return .failure(error)
        }
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
