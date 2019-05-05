//
//  NetworkHTTPPerformer.swift
//  Network
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation
import UIKit

/// A generic HTTP Performer. For detailed doc please refer to HTTPPerformer protocol
struct NetworkHTTPPerformer: HTTPPerformer {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func perform(_ request: URLRequest, completion: @escaping (NetworkResult<Data?, NetworkError>) -> Void) {
        setNetworkActivityIndicatorVisible(true)
        
        session.loadData(from: request) { (data, response, error) in
            self.setNetworkActivityIndicatorVisible(false)
            
            if error != nil {
                completion(.failure(NetworkError.requestError))
            } else {
                completion(self.validate(HTTPResponse(data: data, response: response, error: error)))
            }
        }
    }
    
    func perform(_ request: URLRequest, waitUpTo timeOut: DispatchTime = .now() + .seconds(5), completion: @escaping (NetworkResult<Data?, NetworkError>) -> Void) {
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
    
    private func validate(_ response: HTTPResponse) -> NetworkResult<Data?, NetworkError> {
        
        switch response.statusCode {
        case 200...299:
            return .success(response.data)
            
        case 400:
            return .failure(NetworkError.requestError)
            
        case 401, 403:
            return .failure(NetworkError.notAuthenticated)
            
        case 402:
            return .failure(NetworkError.notPermitted)
            
        case 404:
            return .failure(NetworkError.resourceNotFound(error: response.error, payload: response.data))
            
        case 405:
            return .failure(NetworkError.methodNotAllowed)
            
        case 412:
            return .failure(NetworkError.preconditionFailed)
            
        case 429:
            return .failure(NetworkError.tooManyRequests)
            
        default:
            return .failure(NetworkError.serverError)
        }
    }
}

extension NetworkHTTPPerformer {
    private func setNetworkActivityIndicatorVisible(_ visible: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = visible
        }
    }
}
