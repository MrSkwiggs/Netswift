//
//  NetworkRequest.swift
//  Network
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

/// Generic structure that defines its own Response type. Comes with a few convenience extensions for common types such as JSON
protocol NetworkRequest {
    
    /// Defines the data type of the request's response (if it succeeeded)
    associatedtype Response = JSONDecodable
    
    /// Defines the expected raw type the request expects from the back end. Data by default
    associatedtype IncomingType = Data
    
    /**
     Tries to generate a URLRequest given the specific internals of the NetworkRequest. Might fail.
     - parameter completion: A completion block that takes in a NetworkResult that either succeeds with a useable URLRequest, or fails with a NetworkError
     */
    func serialise(_ handler: @escaping NetworkHandler<URLRequest>)
    
    /**
     Tries to decode raw Data into a Foundation Any object.
     - parameter data: Encoded raw data
     - returns: A NetworkResult that either succeeds with Any object, or fails with a NetworkError.
     */
    func decode(_ data: Data?) -> NetworkResult<Any, NetworkError>
    
    /**
     Tries to cast a Foundation Any object to the request's expected IncomingType
     - parameter any: A Foundation object of Any type
     - returns: A NetworkResult that either succeeds with an object of IncomingType, or fails with a NetworkError.
     */
    func cast(_ any: Any) -> NetworkResult<IncomingType, NetworkError>
    
    /**
     Tries to interpret any incoming data to build a fully-fledged Response object.
     - parameter incomingData: freeform data of the expected IncomingType
     - returns: A NetworkResult that either succeeds with a Response object, or fails with a NetworkError.
     */
    func deserialise(_ incomingData: IncomingType) -> NetworkResult<Response, NetworkError>
}

// MARK: - Convenience Deserialising

/// Deserialising JSONDecodable objects
extension NetworkRequest where IncomingType == Data, Response: JSONDecodable {
    func deserialise(_ incomingData: Data) -> NetworkResult<Response, NetworkError> {
        do {
            let decodedResponse = try JSONDecoder().decode(Response.self, from: incomingData)
            return .success(decodedResponse)
            
        } catch let error as DecodingError {
            return .failure(.responseDecodingError(error: error))
        } catch {
            return .failure(.unexpectedResponseError)
        }
    }
}

/// Deserialising Images
extension NetworkRequest where IncomingType == Data, Response: UIImage {
    func deserialise(_ incomingData: Data) -> NetworkResult<Response, NetworkError> {
        if let image = Response(data: incomingData) {
            return .success(image)
        } else {
            return .failure(.unexpectedResponseError)
        }
    }
}


// MARK: - Convenience Decoding for common types

/// When the request expects freeform data, decoding is done during deserialisation
extension NetworkRequest where IncomingType == Data {
    func decode(_ data: Data?) -> NetworkResult<Any, NetworkError> {
        guard let data = data else {
            return .failure(.noResponseError)
        }
        
        return .success(data)
    }
}

// MARK: - Convenience Casting

/// Generic casting
extension NetworkRequest {
    func cast(_ any: Any) -> NetworkResult<IncomingType, NetworkError> {
        if let castedObject = any as? IncomingType {
            return .success(castedObject)
        }
        
        return .failure(.responseCastingError)
    }
}
