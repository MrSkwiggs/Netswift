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
     Specifies which HTTP headers to use for this request
     - important: Defaults to empty array.
     */
    var headers: [RequestHeader] { get }
    
    /**
     Tries to generate a URLRequest given the specific internals of the NetswiftRequest. Might fail.
     - parameter completion: A completion block that takes in a NetswiftResult that either succeeds with a useable URLRequest, or fails with a Netswift.Error
     */
    func serialise() -> NetswiftResult<URLRequest>
    
    /**
     Tries to decode raw Data into a Foundation Any object.
     - parameter data: Encoded raw data
     - returns: A NetswiftResult that either succeeds with Any object, or fails with a Netswift.Error.
     */
    func decode(_ data: Data?) -> NetswiftResult<Any>
    
    /**
     Tries to cast a Foundation Any object to the request's expected IncomingType
     - parameter any: A Foundation object of Any type
     - returns: A NetswiftResult that either succeeds with an object of IncomingType, or fails with a Netswift.Error.
     */
    func cast(_ any: Any) -> NetswiftResult<IncomingType>
    
    /**
     Tries to interpret any incoming data to build a fully-fledged Response object.
     - parameter incomingData: freeform data of the expected IncomingType
     - returns: A NetswiftResult that either succeeds with a Response object, or fails with a Netswift.Error.
     */
    func deserialise(_ incomingData: IncomingType) -> NetswiftResult<Response>
}

public extension NetswiftRequest {
    var headers: [RequestHeader] {
        return []
    }
}

// MARK: - Convenience Serialising

public extension NetswiftRequest where Self: NetswiftRoute {
    func serialise() -> NetswiftResult<URLRequest> {
        var request = URLRequest(url: self.url)
        request.setHTTPMethod(self.method)
        request.setHeaders(self.headers)
        
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
            return .failure(.responseDecodingError(error: error, payload: incomingData))
        } catch {
            return .failure(.unexpectedResponseError)
        }
    }
}

// MARK: - Convenience Decoding for common types

/// When the request expects freeform data, decoding is done during deserialisation
public extension NetswiftRequest where IncomingType == Data {
    func decode(_ data: Data?) -> NetswiftResult<Any> {
        guard let data = data else {
            return .failure(.noResponseError)
        }
        
        return .success(data)
    }
}

// MARK: - Convenience Casting

/// Generic casting
public extension NetswiftRequest {
    func cast(_ any: Any) -> NetswiftResult<IncomingType> {
        if let castedObject = any as? IncomingType {
            return .success(castedObject)
        }
        
        return .failure(.responseCastingError)
    }
}
