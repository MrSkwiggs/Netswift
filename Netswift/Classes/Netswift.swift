//
//  Netswift.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation
import UIKit

/// Generic NetswiftRequest performer. For detailed doc please refer to NetswiftNetworkPerformer protocol
public final class Netswift: NetswiftNetworkPerformer {
    
    private var concurrentRequests: Int {
        didSet {
            setNetworkActivityIndicatorVisible(concurrentRequests != 0)
        }
    }
    
    /// Dictates whether or not this class should set `UIApplication.shared.isNetworkActivityIndicatorVisible` to true while performing requests
    /// - note: `true` by default
    var shouldHandleNetworkActivityIndicator: Bool = true

    let requestPerformer: NetswiftNetworkHTTPPerformer

    init(requestPerformer: NetswiftNetworkHTTPPerformer = NetswiftHTTPPerformer()) {
        self.requestPerformer = requestPerformer
        self.concurrentRequests = 0
    }


    public func perform<T: NetswiftRequest>(_ request: T, handler: @escaping NetswiftHandler<T.Response>) {
        request.serialise() { result in
            switch result {
            case .success(let url):
                self.concurrentRequests += 1
                self.requestPerformer.perform(url) { response in
                    self.concurrentRequests -= 1
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

extension Netswift {
    private func setNetworkActivityIndicatorVisible(_ visible: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }
}
