//
//  NetswiftSession.swift
//  Netswift
//
//  Created by Declan McKenna on 05/05/2019.
//  Copyright © 2019 Skwiggs Inc. All rights reserved.
//

import Foundation

///Protocol that enables us to Mock URLSession
protocol NetswiftSession {
    typealias RequestHandler = (NetswiftHTTPResponse) -> Void
    
    func perform(_ urlRequest: URLRequest, handler: @escaping RequestHandler)
}

///Extension to make URLSession compliant with NetswiftSession
extension URLSession: NetswiftSession {
    
    ///DataTask call made via NetswiftSession Protocol
    func perform(_ urlRequest: URLRequest, handler: @escaping RequestHandler) {
        let task = dataTask(with: urlRequest) { data, response, error in
            handler(.init(data: data, response: response, error: error))
        }
        task.resume()
    }
}
