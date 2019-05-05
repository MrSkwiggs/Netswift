//
//  NetworkSession.swift
//  Netswift
//
//  Created by Declan McKenna on 05/05/2019.
//  Copyright © 2019 Skwiggs Inc. All rights reserved.
//

import Foundation

///Protocol that enables us to Mock URLSession
protocol NetworkSession {
    
    func loadData(from urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

///Extension to make URLSession compliant with NetworkSession
extension URLSession: NetworkSession {
    
    ///DataTask call made via NetworkSession Protocol
    func loadData(from urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: urlRequest, completionHandler: completionHandler)
        task.resume()
    }
}
