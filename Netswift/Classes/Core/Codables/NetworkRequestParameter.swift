//
//  NetworkGenericParameter.swift
//  OneFit
//
//  Created by Dorian Grolaux on 01/05/2019.
//  Copyright © 2019 OneFit. All rights reserved.
//

import Foundation

/// Generic named & typed parameter. Main use is for request bodies. Can be encoded.
enum NetworkRequestParameter {
    
    struct NamedParameter<T: Encodable> {
        let name: String?
        let value: T
    }
    
    case int(NamedParameter<Int>)
    case string(NamedParameter<String>)
    case bool(NamedParameter<Bool>)
    case float(NamedParameter<Float>)
    case double(NamedParameter<Double>)
    
    case array([NetworkRequestParameter])
    case object([NetworkRequestParameter])
    
    var networkRequestParameter: NetworkRequestParameter? {
        return self
    }
}

extension NetworkRequestParameter.NamedParameter: Encodable {
    func encode(to encoder: Encoder) throws {
        guard let name = name else {
            try value.encode(to: encoder)
            return
        }
        
        try [name: value].encode(to: encoder)
    }
}

extension NetworkRequestParameter: Encodable {
    func encode(to encoder: Encoder) throws {
        switch self {
        case .int(let value):
            try value.encode(to: encoder)
            
        case .bool(let value):
            try value.encode(to: encoder)
            
        case .string(let value):
            try value.encode(to: encoder)
            
        case .float(let value):
            try value.encode(to: encoder)
            
        case .double(let value):
            try value.encode(to: encoder)
            
        case .array(let array):
            try array.encode(to: encoder)
        
        case .object(let properties):
            try properties.forEach { property in
                try property.encode(to: encoder)
            }
        }
    }
}
