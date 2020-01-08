//
//  NetswiftMIMEType.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Standard and custom HTTP MIME Types
public enum NetswiftMIMEType: Hashable {
    // MARK: - Text
    
    /// text/plain
    case plainText
    
    /// text/html
    case html
    
    // MARK: - Application
    
    /// application/json
    case json
    
    /// application/javascript
    case javascript
    
    /// application/pdf
    case pdf
    
    /// application/zip
    case zip
    
    /// application/octet-stream
    case data
    
    // MARK: - Audio
    
    /// audio/mpeg
    case mpeg
    
    /// audio/vorbis
    case vorbis
    
    // MARK: - Multipart
    
    /// multipart/form-data; boundary=\<boundary\>
    case multipart(Multipart)
    
    // MARK: - Custom
    
    /// A custom MIME type.
    case custom(type: String)
    
    var rawValue: String {
        switch self {
        case .plainText: return "text/plain"
        case .html: return "text/html"
        case .javascript: return "application/javascript"
        case .json: return "application/json"
        case .pdf: return "application/pdf"
        case .zip: return "application/zip"
        case .data: return "application/octet-stream"
        case .mpeg: return "audio/mpeg"
        case .vorbis: return "audio/vorbis"
        case .multipart(let multipart): return multipart.rawValue
        case .custom(let type): return type
        }
    }
}

public extension NetswiftMIMEType {
    enum Multipart: Hashable {
        case form(boundary: String)
        case byteRange(boundary: String)
        
        var boundary: String {
            switch self {
            case .form(let boundary), .byteRange(let boundary):
                return boundary
            }
        }
        
        var rawValue: String {
            var value: String = "multipart/"
            
            switch self {
            case .byteRange: value += "form-data"
            case .form: value += "byteranges"
            }
            
            value += "; boundary=\(boundary)"
            return value
        }
    }
}
