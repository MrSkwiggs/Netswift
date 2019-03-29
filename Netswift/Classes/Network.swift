//
//  Network.swift
//  Network
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

/// Main NetworkRequest performer. For detailed doc please refer to NetworkPerformer protocol
struct Network: NetworkPerformer {

    let requestPerformer: HTTPPerformer

    init(requestPerformer: HTTPPerformer = NetworkHTTPPerformer()) {
        self.requestPerformer = requestPerformer
    }


    func perform<T: NetworkRequest>(_ request: T, handler: @escaping (NetworkResult<T.Response, NetworkError>) -> Void) {
        request.serialise() { result in
            switch result {
            case .success(let url):
                self.requestPerformer.perform(url) { response in
                    let networkResponse = response
                        .check(request.decode)
                        .check(request.cast)
                        .check(request.deserialise)

                    handler(networkResponse)
                }

            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
