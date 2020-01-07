//
//  NetswiftHTTPPerformer.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// A generic HTTP Performer. For detailed doc please refer to NetswiftNetworkHTTPPerformer protocol
public final class NetswiftHTTPPerformer: NetswiftNetworkHTTPPerformer {
    
    private let session: NetswiftSession
    
    public init(session: NetswiftSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func perform(_ request: URLRequest, completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        return session.perform(request) { response in
            completion(self.validate(response))
        }
    }
    
    public func perform(_ request: URLRequest, waitUpTo timeOut: DispatchTime = .now() + .seconds(5), completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        let dispatchGroup = DispatchGroup()
        
        if dispatchGroup.wait(timeout: timeOut) == .timedOut {
            completion(.failure(.timedOut))
        }
        
        dispatchGroup.enter()
        return self.perform(request) { result in
            dispatchGroup.leave()
            
            completion(result)
        }
    }
    
    private func validate(_ response: NetswiftHTTPResponse) -> NetswiftResult<Data?> {
        switch response.statusCode {
        case 200...299:
            return .success(response.data)

        case 400:
            return .failure(.requestError)

        case 401:
            return .failure(.notAuthenticated)

        case 402:
            return .failure(.paymentRequired(payload: response.data))

        case 403:
            return .failure(.notPermitted)

        case 404:
            return .failure(.resourceNotFound(error: response.error, payload: response.data))

        case 405:
            return .failure(.methodNotAllowed)

        case 412:
            return .failure(.preconditionFailed)

        case 429:
            return .failure(.tooManyRequests)

        case 500:
            return .failure(.serverError(payload: response.data))

        default:
            return .failure(.unknown(payload: response.data))

        }    }
}
