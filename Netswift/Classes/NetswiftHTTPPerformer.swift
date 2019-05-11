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
    
    init(session: NetswiftSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func perform(_ request: URLRequest, completion: @escaping (NetswiftResult<Data?, NetswiftError>) -> Void) {
        session.perform(request) { response in
            
            if let error = response.error {
                return completion(.failure(NetswiftError.requestError(with: error)))
            }
            
            completion(self.validate(response))
        }
    }
    
    public func perform(_ request: URLRequest, waitUpTo timeOut: DispatchTime = .now() + .seconds(5), completion: @escaping (NetswiftResult<Data?, NetswiftError>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        DispatchQueue.main.async {
            dispatchGroup.enter()
            
            self.perform(request) { result in
                dispatchGroup.leave()
                
                completion(result)
            }
            
            if dispatchGroup.wait(timeout: timeOut) == .timedOut {
                completion(.failure(.timedOut))
            }
        }
    }
    
    private func validate(_ response: NetswiftHTTPResponse) -> NetswiftResult<Data?, NetswiftError> {
        
        switch response.statusCode {
        case 200...299:
            return .success(response.data)
            
        case 400:
            return .failure(NetswiftError.badRequest)
            
        case 401, 403:
            return .failure(NetswiftError.notAuthenticated)
            
        case 402:
            return .failure(NetswiftError.notPermitted)
            
        case 404:
            return .failure(NetswiftError.resourceNotFound(with: response.error, payload: response.data))
            
        case 405:
            return .failure(NetswiftError.methodNotAllowed)
            
        case 412:
            return .failure(NetswiftError.preconditionFailed)
            
        case 429:
            return .failure(NetswiftError.tooManyRequests)
            
        default:
            return .failure(NetswiftError.serverError)
        }
    }
}
