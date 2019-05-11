//
//  YourEndpoint+Request.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 11/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Netswift

extension API.YourEndpoint: NetswiftRequest {
    typealias Response = String
    
    func serialise(_ handler: @escaping NetswiftHandler<URLRequest>) {
        let request = URLRequest(url: self.url)
        
        handler(.success(request))
    }
}
