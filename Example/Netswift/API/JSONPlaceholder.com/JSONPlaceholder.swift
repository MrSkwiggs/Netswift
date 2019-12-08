//
//  JSONPlaceholder.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 11/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Netswift

extension API.JSONPlaceholder: NetswiftRoute {
    var host: String? {
        return "jsonplaceholder.typicode.com"
    }
    
    var path: String? {
        switch self {
        case .getAll: return "todos"
        case .getById(let id): return "todos/\(id)"
        }
    }
}

extension API.JSONPlaceholder: NetswiftRequest {
    typealias Response = [JSONTodo]
    
    func deserialise(_ incomingData: Data) -> NetswiftResult<[JSONTodo], NetswiftError> {
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode([JSONTodo].self, from: incomingData)
            return .success(decodedResponse)
        } catch {
            return .failure(.responseDecodingError(error: nil))
        }
    }
    
    func serialise(_ handler: @escaping NetswiftHandler<URLRequest>) {
        let request = URLRequest(url: self.url)
        
        handler(.success(request))
    }
}
