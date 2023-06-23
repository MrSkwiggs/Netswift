//
//  NetswiftHeaders.swift
//  
//
//  Created by Dorian on 25/01/2023.
//

import Foundation

public struct NetswiftHeaders {
    
    public init(
        authorization: NetswiftAuthorizationType? = nil,
        accept: MimeType = .json,
        contentType: MimeType = .json,
        additionalHeaders: Set<RequestHeader> = []
    ) {
        self.authorization = authorization
        self.accept = accept
        self.contentType = contentType
        self.additionalHeaders = additionalHeaders
    }
    
    /**
     Specifies what type of authentication a request should use
     
     - important: Defaults to `nil`
     */
    public var authorization: NetswiftAuthorizationType?
    
    /**
     Specifies what type of content a request expects back.
     
     - important: Defaults to `.json`
     */
    public var accept: MimeType
    
    /**
     Specifies what type of content a request emits.
     
     - important: Defaults to `.json`
     */
    public var contentType: MimeType
    
    /**
     Specifies additional HTTP headers to use for a request.
     
     These headers will be concatenated with any other already specified header (such as Content-Type or Accept).
     
     - note: Set **Content-Type** or **Accept** headers through `contentType` or `accept` protocol vars.
     - important: Defaults to empty array.
     */
    public var additionalHeaders: Set<RequestHeader> = []
    
    /**
     A set constructed from all headers defined in this object.
     
     - warning: Headers defined under `additionalHeaders` are overwritten by existing struct members such as `accept`, `contentType` or `authorization`.
     */
    public var all: Set<RequestHeader> {
        var all = additionalHeaders
        all.update(with: .accept(accept))
        all.update(with: .contentType(contentType))
        if let authorization = authorization {
            all.update(with: .authorization(authorization))
        }

        return all
    }
}
