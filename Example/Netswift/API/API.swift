//
//  YourAPI.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 11/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Netswift

struct API {
    
    private let performer: NetswiftNetworkPerformer
    fileprivate static let shared = API()
    
    private init(performer: NetswiftNetworkPerformer = Netswift()) {
        self.performer = performer
    }
    
    /// Convenience bridge function between NetswiftRequestPerformable & NetswiftPerformer
    fileprivate func perform<T: NetswiftRequest>(_ request: T, _ handler: @escaping NetswiftHandler<T.Response>) -> NetswiftTask? {
        return performer.perform(request, handler: handler)
    }
}

extension NetswiftRequestPerformable where Self: NetswiftRequest {
    @discardableResult func perform(_ handler: @escaping NetswiftHandler<Self.Response>) -> NetswiftTask? {
        return API.shared.perform(self, handler)
    }
}

extension API {
    enum YourEndpoint: NetswiftRequestPerformable {
        /// Fetches example.com as HTML
        case example
    }
    
    enum JSONPlaceholder: NetswiftRequestPerformable {
        case getAll
        case getById(Int)
    }
}
