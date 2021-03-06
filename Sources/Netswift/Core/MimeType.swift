//
//  MimeType.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Standard and custom HTTP MIME Types
public enum MimeType: Hashable {
    // MARK: - Text
    
    /// text/plain
    case text
    
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
    
    // MARK: - Image
    
    /// image/jpeg
    case jpg
    
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
    
    public var rawValue: String {
        switch self {
        case .text: return "text/plain"
        case .html: return "text/html"
        case .javascript: return "application/javascript"
        case .json: return "application/json"
        case .pdf: return "application/pdf"
        case .zip: return "application/zip"
        case .data: return "application/octet-stream"
        case .jpg: return "image/jpeg"
        case .mpeg: return "audio/mpeg"
        case .vorbis: return "audio/vorbis"
        case .multipart(let multipart): return multipart.rawValue
        case .custom(let type): return type
        }
    }
}

public extension MimeType {
    enum Multipart: Hashable {
        case form(boundary: String)
        case byteRange(boundary: String)
        
        public var boundary: String {
            switch self {
            case .form(let boundary), .byteRange(let boundary):
                return boundary
            }
        }
        
        public var rawValue: String {
            var value: String = "multipart/"
            
            switch self {
            case .byteRange: value += "byteranges"
            case .form: value += "form-data"
            }
            
            value += "; boundary=\(boundary)"
            return value
        }
    }
}
