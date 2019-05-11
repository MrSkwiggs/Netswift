//
//  JSPlaceholder+Route.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 11/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Netswift

extension API.JSONPlaceholder: NetswiftRoute {
    var host: String {
        return "jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .getAll: return "todos"
        case .getById(let id): return "todos/\(id)"
        }
    }
}
