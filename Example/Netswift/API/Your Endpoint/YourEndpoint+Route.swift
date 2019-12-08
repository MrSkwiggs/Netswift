//
//  YourEndpoint+Route.swift
//  Netswift_Example
//
//  Created by Dorian Grolaux on 11/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Netswift

extension API.YourEndpoint: NetswiftRoute {
    var host: String? {
        return "example.com"
    }
}
