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
    
    fileprivate func perform<T: NetswiftRequest>(_ request: T, _ handler: @escaping NetswiftHandler<T.Response>) {
        performer.perform(request, handler: handler)
    }
}

extension NetswiftRequestPerformable where Self: NetswiftRequest {
    func perform(_ handler: @escaping NetswiftHandler<Self.Response>) {
        API.shared.perform(self, handler)
    }
}

extension API {
    enum YourEndpoint: NetswiftRequestPerformable {
        case example
    }
    
    enum JSONPlaceholder: NetswiftRequestPerformable {
        case getAll
        case getById(Int)
    }
}
