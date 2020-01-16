//
//  JSONTodo.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 11/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

struct JSONTodo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
