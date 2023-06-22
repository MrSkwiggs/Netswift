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
    
    private init(performer: NetswiftNetworkPerformer = NetswiftPerformer()) {
        self.performer = performer
    }
    
    /// Convenience bridge function between NetswiftRequestPerformable & NetswiftPerformer
    fileprivate func perform<T: NetswiftRequest>(_ request: T, deadline: DispatchTime? = nil, _ handler: @escaping NetswiftHandler<T.Response>) -> NetswiftTask? {
        return performer.perform(request, deadline: deadline, handler: handler)
    }

    @available(iOS 13, *)
    fileprivate func perform<T: NetswiftRequest>(_ request: T) async -> NetswiftResult<T.Response> {
        return await performer.perform(request)
    }
}

extension NetswiftRequestPerformable {
    @discardableResult func perform(_ handler: @escaping NetswiftHandler<Self.Response>) -> NetswiftTask? {
        return API.shared.perform(self, handler)
    }
    
    @discardableResult func perform(deadline: DispatchTime, _ handler: @escaping NetswiftHandler<Self.Response>) -> NetswiftTask? {
        return API.shared.perform(self, deadline: deadline, handler)
    }

    @available(iOS 13, *)
    func perform() async -> NetswiftResult<Self.Response> {
        return await API.shared.perform(self)
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
