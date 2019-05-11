//
//  JSONCodable.swift
//  Netswift
//
//  Created by Dorian Grolaux on 03/05/2019.
//  Copyright © 2019 Skwiggs. All rights reserved.
//

import Foundation

/// Specific Codable, should only be used in conjuction with JSONEncoder/Decoder
public protocol JSONCodable where Self: JSONEncodable & JSONDecodable {}
