//
//  NetworkHTTPPerformer.swift
//  Network
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation
import UIKit

/// Our main HTTP Performer. For detailed doc please refer to HTTPPerformer class
struct NetworkHTTPPerformer: HTTPPerformer {
    let session: URLSession
    
    init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    func perform(_ request: URLRequest, completion: @escaping (NetworkResult<Data?, NetworkError>) -> Void) {
        setNetworkActivityIndicatorVisible(true)
        
        
        session.dataTask(with: request) { (data, response, error) in
            self.setNetworkActivityIndicatorVisible(false)
            
            if error != nil {
                completion(.failure(NetworkError.requestError))
            } else {
                completion(self.validate(HTTPResponse(data: data, response: response, error: error)))
            }
        }.resume()
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
