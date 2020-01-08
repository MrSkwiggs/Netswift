//
//  NetswiftHTTPType.swift
//  Netswift
//
//  Created by Dorian Grolaux on 02/07/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Standard and custom HTTP Types
public enum NetswiftHTTPType: Hashable {
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
        case .custom(let type): return type
        }
    }
}
