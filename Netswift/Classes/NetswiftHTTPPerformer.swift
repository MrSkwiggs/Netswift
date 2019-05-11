//
//  NetswiftHTTPPerformer.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation
import UIKit

/// A generic HTTP Performer. For detailed doc please refer to HTTPPerformer protocol
public struct NetswiftHTTPPerformer: HTTPPerformer {
    
    let session: URLSession
    
    init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    func perform(_ request: URLRequest, completion: @escaping (NetswiftResult<Data?, NetswiftError>) -> Void) {
        setNetworkActivityIndicatorVisible(true)
        
        session.dataTask(with: request) { (data, response, error) in
            self.setNetworkActivityIndicatorVisible(false)
            
            if error != nil {
                completion(.failure(NetswiftError.requestError))
            } else {
                completion(self.validate(NetswiftHTTPResponse(data: data, response: response, error: error)))
            }
        }.resume()
    }
    
    func perform(_ request: URLRequest, waitUpTo timeOut: DispatchTime = .now() + .seconds(5), completion: @escaping (NetswiftResult<Data?, NetswiftError>) -> Void) {
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
            return .failure(NetswiftError.requestError)
            
        case 401, 403:
            return .failure(NetswiftError.notAuthenticated)
            
        case 402:
            return .failure(NetswiftError.notPermitted)
            
        case 404:
            return .failure(NetswiftError.resourceNotFound(error: response.error, payload: response.data))
            
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

extension NetswiftHTTPPerformer {
    private func setNetworkActivityIndicatorVisible(_ visible: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }
}
