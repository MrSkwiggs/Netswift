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
    
    @discardableResult open func perform<Request: NetswiftRequest>(_ request: Request, handler: @escaping NetswiftHandler<Request.Response>) -> NetswiftTask? {
        switch request.serialise() {
        case .success(let url):
            return self.requestPerformer.perform(url) { response in
                
                switch response {
                case .success:
                    let networkResponse = response
                        .flatMap(request.decode)
                        .flatMap(request.cast)
                        .flatMap(request.deserialise)
                    handler(networkResponse)
                    
                case .failure(let error):
                    handler(request.intercept(error))
                }
            }
            
        case .failure(let error):
            handler(.failure(error))
        }
        return nil
    }

    @available(iOS 15, *)
    open func perform<T: NetswiftRequest>(_ request: T) async -> NetswiftResult<T.Response> {
        await withCheckedContinuation { continuation in
            switch request.serialise() {
            case .success(let url):
                _ = self.requestPerformer.perform(url) { response in

                    switch response {
                    case .success:
                        let networkResponse = response
                            .flatMap(request.decode)
                            .flatMap(request.cast)
                            .flatMap(request.deserialise)
                        continuation.resume(returning: networkResponse)
                    case .failure(let error):
                        continuation.resume(returning: .failure(error))
                    }
                }
            case .failure(let error):
                continuation.resume(returning: .failure(error))
            }
        }
    }
}
