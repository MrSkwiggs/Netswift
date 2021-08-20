//
//  NetswiftRequest.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// Generic structure that defines its own Response type. Comes with a few convenience extensions for common types such as JSON
public protocol NetswiftRequest {
    
    /// Defines the data type of the request's response (if it succeeeded)
    associatedtype Response = Decodable
    
    /// Defines the expected raw type the request expects from the back end. Data by default
    associatedtype IncomingType = Data
    
    /**
     Specifies additional HTTP headers to use for this request.
     
     These headers will be concatenated with any other already specified header (such as Content-Type or Accept).
     
     - note: Set Content-Type or Accept headers through `contentType` or `accept` protocol vars.
     - important: Defaults to empty array.
     */
    var additionalHeaders: [RequestHeader] { get }
    
    /**
     Specifies what type of content this request emits.
     
     - important: Defaults to `.json`
     */
    var contentType: MimeType { get }
    
    /**
     Specifies which encoder should be used for encoding this request's body
     
     - important: Defaults to `JSONEncoder()`
     */
    var bodyEncoder: NetswiftEncoder? { get }
    
    /**
     Encodes any arbitrary data defined by this request with the given encoder to be used as the request's body.
     
     - important: Returns `nil` by default
     */
    func body(encodedBy encoder: NetswiftEncoder?) -> Data?
    
    /**
     Specifies what type of content this request expects back.
     
     - important: Defaults to `.json`
     */
    var accept: MimeType { get }
    
    /**
     Tries to generate a URLRequest given the specific internals of the NetswiftRequest. Might fail.
     - parameter completion: A completion block that takes in a NetswiftResult that either succeeds with a useable URLRequest, or fails with a NetswiftError
     */
    func serialise() -> NetswiftResult<URLRequest>
    
    /**
     Tries to decode raw Data into a Foundation Any object.
     - parameter data: Encoded raw data
     - returns: A NetswiftResult that either succeeds with Any object, or fails with a NetswiftError.
     */
    func decode(_ data: Data?) -> NetswiftResult<Any>
    
    /**
     Tries to cast a Foundation Any object to the request's expected IncomingType
     - parameter any: A Foundation object of Any type
     - returns: A NetswiftResult that either succeeds with an object of IncomingType, or fails with a NetswiftError.
     */
    func cast(_ any: Any) -> NetswiftResult<IncomingType>
    
    /**
     Tries to interpret any incoming data to build a fully-fledged Response object.
     - parameter incomingData: freeform data of the expected IncomingType
     - returns: A NetswiftResult that either succeeds with a Response object, or fails with a NetswiftError.
     */
    func deserialise(_ incomingData: IncomingType) -> NetswiftResult<Response>
    
    /**
     Tries to intercept and handle an error thrown while the Request is being performed.
     
     This allows to handle network & related errors directly from within a Request's declaration.
     - parameter error: The error thrown
     - note: Returns `.failure(error)` by default
     */
    func intercept(_ error: NetswiftError) -> NetswiftResult<Response>
}

public extension NetswiftRequest {
    var additionalHeaders: [RequestHeader] {
        return []
    }
    
    var contentType: MimeType {
        return .json
    }
    
    var bodyEncoder: NetswiftEncoder? {
        return JSONEncoder()
    }
    
    func body(encodedBy encoder: NetswiftEncoder?) -> Data? {
        return nil
    }
    
    var accept: MimeType {
        return .json
    }
    
    func intercept(_ error: NetswiftError) -> NetswiftResult<Response> {
        return .failure(error)
    }
}

// MARK: - Convenience Serialising

public extension NetswiftRequest where Self: NetswiftRoute {
    func serialise() -> NetswiftResult<URLRequest> {
        var request = URLRequest(url: self.url)
        request.setHTTPMethod(self.method)
        
        var headers = additionalHeaders
        
        headers.append(.contentType(contentType))
        headers.append(.accept(accept))
        
        if let encoder = bodyEncoder {
            request.httpBody = body(encodedBy: encoder)
        }
        
        request.addHeaders(headers)
        
        return .success(request)
    }
}

// MARK: - Convenience Deserialising

/// Deserialising JSONDecodable objects
public extension NetswiftRequest where IncomingType == Data, Response: Decodable {
    func deserialise(_ incomingData: Data) -> NetswiftResult<Response> {
        do {
            let decodedResponse = try JSONDecoder().decode(Response.self, from: incomingData)
            return .success(decodedResponse)
            
        } catch let error as DecodingError {
            return .failure(.init(category: .responseDecodingError(error: error), payload: incomingData))
        } catch {
            return .failure(.init(category: .unexpectedResponseError, payload: incomingData))
        }
    }
}

public extension NetswiftRequest where IncomingType == Data, Response == String {
    func deserialise(_ incomingData: Data) -> NetswiftResult<Response> {
        guard let string = String(data: incomingData, encoding: .utf8) else {
            return .failure(.init(category: .unexpectedResponseError, payload: incomingData))
        }
        return .success(string)
    }
}

// MARK: - Convenience Decoding for common types

/// When the request expects freeform data, decoding is done during deserialisation
public extension NetswiftRequest where IncomingType == Data {
    func decode(_ data: Data?) -> NetswiftResult<Any> {
        guard let incomingData = data else {
            return .failure(.init(category: .noResponseError, payload: data))
        }
        
        return .success(incomingData)
    }
}

// MARK: - Convenience Casting

/// Generic casting
public extension NetswiftRequest {
    func cast(_ any: Any) -> NetswiftResult<IncomingType> {
        if let castedObject = any as? IncomingType {
            return .success(castedObject)
        }
        
        return .failure(.init(category: .responseCastingError, payload: any as? Data))
    }
}
