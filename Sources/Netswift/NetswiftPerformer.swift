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
    
    @discardableResult public func perform<T: NetswiftRequest>(_ request: T, handler: @escaping NetswiftHandler<T.Response>) -> NetswiftTask? {
        switch request.serialise() {
        case .success(let url):
            return self.requestPerformer.perform(url) { response in
                let networkResponse = response
                    .flatMap(request.decode)
                    .flatMap(request.cast)
                    .flatMap(request.deserialise)
                handler(networkResponse)
            }
            
        case .failure(let error):
            handler(.failure(error))
        }
        return nil
    }
}
