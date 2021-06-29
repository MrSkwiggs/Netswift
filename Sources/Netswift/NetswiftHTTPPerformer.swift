//
//  NetswiftHTTPPerformer.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// A generic HTTP Performer. For detailed doc please refer to HTTPPerformer protocol
open class NetswiftHTTPPerformer: HTTPPerformer {
    
    private let session: NetswiftSession
    
    public init(session: NetswiftSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    open func perform(_ request: URLRequest, completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        return session.perform(request) { response in
            completion(self.validate(response))
        }
    }
    
    open func perform(_ request: URLRequest, waitUpTo timeOut: DispatchTime = .now() + .seconds(5), completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        let dispatchGroup = DispatchGroup()
        
        if dispatchGroup.wait(timeout: timeOut) == .timedOut {
            completion(.failure(.init(category: .timedOut, payload: nil)))
        }
        
        dispatchGroup.enter()
        return self.perform(request) { result in
            dispatchGroup.leave()
            
            completion(result)
        }
    }
    
    private func validate(_ response: NetswiftHTTPResponse) -> NetswiftResult<Data?> {
        guard let statusCode = response.statusCode else {
            guard let error = response.error else {
                return .failure(.init(category: .unknown(httpStatusCode: nil), payload: response.data))
            }
            return .failure(.init(category: .generic(error: error), payload: response.data))
        }
        
        if let category = NetswiftError.Category.from(httpStatusCode: statusCode) {
            return .failure(.init(category: category, payload: response.data))
        } else {
            return .success(response.data)
        }
    }
}
