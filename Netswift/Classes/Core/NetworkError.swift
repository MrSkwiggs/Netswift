//
//  NetworkError.swift
//  Network
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Dorian Grolaux. All rights reserved.
//

import Foundation

/// All the errors that can be raised while performing HTTP requests
enum NetworkError: Error {
    
    /// The request couldn't be serialised before being sent out
    case requestSerialisationError
    
    ///	The request couldn't be processed by the server
    case requestError
    
    /// The server encountered an internal error while processing the request
    case serverError
    
    /// The specified resource could not be found on the server (404)
    case resourceNotFound(error: Swift.Error?, payload: Data?)
    
    /// The response returned by the server does not conform to expected type
    case unexpectedResponseError
    
    /// The response returned by the server is empty / nil
    case noResponseError
    
    /// The response's raw data could not be understood
    case responseDecodingError(error: DecodingError)
    
    /// The response could not be casted to the Request's IncomingType
    case responseCastingError
    
    /// Cannot authenticate the request; authentication needed
    case notAuthenticated
    
    /// The server didn't allow this request for this user
    case notPermitted
    
    /// The request took too long to return. Potential causes include bad network and server issues.
    case timedOut
    
    /// The server does not meet one of the preconditions that the requester put on the request
    case preconditionFailed
    
    /// A request method is not supported for the requested resource
    case methodNotAllowed
    
    /// The user has sent too many requests in a given amount of time
    case tooManyRequests
}
