//
//  NetswiftRequestParameter.swift
//  Netswift
//
//  Created by Dorian Grolaux on 01/05/2019.
//  Copyright © 2019 Skwiggs. All rights reserved.
//

import Foundation

/// Generic named & typed parameter. Main use is for request bodies. Can be encoded.
public enum NetswiftRequestParameter {
    
    case int(NamedParameter<Int>)
    case string(NamedParameter<String>)
    case bool(NamedParameter<Bool>)
    case float(NamedParameter<Float>)
    case double(NamedParameter<Double>)
    
    case array([NetswiftRequestParameter])
    case object([NetswiftRequestParameter])
}

// MARK: NamedParameter Generic struct

public extension NetswiftRequestParameter {
    struct NamedParameter<T: Encodable> {
        let name: String?
        let value: T
        
        init(_ name: String, value: T) {
            self.name = name
            self.value = value
        }
        
        init(value: T) {
            self.name = nil
            self.value = value
        }
    }
}

// MARK: NamedParameter Encoding

extension NetswiftRequestParameter.NamedParameter: Encodable {
    public func encode(to encoder: Encoder) throws {
        // if no name is provided, simply encode as a keyless value
        guard let name = name else {
            try value.encode(to: encoder)
            return
        }
        
        // otherwise, encode as a dictionary
        try [name: value].encode(to: encoder)
    }
}

// MARK: NetswiftRequestParameter Encoding

extension NetswiftRequestParameter: Encodable {
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .int(let value): try value.encode(to: encoder)
        case .bool(let value): try value.encode(to: encoder)
        case .string(let value): try value.encode(to: encoder)
        case .float(let value): try value.encode(to: encoder)
        case .double(let value): try value.encode(to: encoder)
        case .array(let array): try array.encode(to: encoder)
            
        case .object(let properties):
            try properties.forEach { property in
                try property.encode(to: encoder)
            }
        }
    }
}
