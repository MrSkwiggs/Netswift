//
//  Tutorial.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 12/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Netswift

enum MyAPI {
    case helloWorld
}

extension MyAPI: NetswiftRoute {
    var host: String? {
        return "my-json-server.typicode.com"
    }
    
    var path: String? {
        switch self {
        case .helloWorld: return "/MrSkwiggs/Netswift-HelloWorld/Netswift"
        }
    }
}

extension MyAPI: NetswiftRequest {
    func serialise(_ handler: @escaping NetswiftHandler<URLRequest>) {
        handler(.success(URLRequest(url: self.url)))
    }
    
    struct Response: JSONDecodable {
        let title: String
    }
}
