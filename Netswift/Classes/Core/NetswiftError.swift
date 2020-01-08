//
//  NetswiftError.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

/// All the errors that can be raised while performing HTTP requests
public enum NetswiftError: Swift.Error {
    
    /// The request couldn't be serialised before being sent out
    case requestSerialisationError

    /// The request couldn't be processed by the server
    case requestError

    /// The server encountered an internal error while processing the request
    case serverError(payload: Data?)

    /// The specified resource could not be found on the server (404)
    case resourceNotFound(error: Swift.Error?, payload: Data?)
    
    /// The specified resource has been permanently removed
    case resourceRemoved(error: Swift.Error?, payload: Data?)
    
    /// The response returned by the server does not conform to expected type
    case unexpectedResponseError

    /// The response returned by the server is empty / nil
    case noResponseError

    /// The response's raw data could not be understood
    case responseDecodingError(error: DecodingError, payload: Data?)

    /// The response could not be casted to the Request's IncomingType
    case responseCastingError

    /// Cannot authenticate the request; authentication needed
    case notAuthenticated

    /// The server requires payment data before it can process the request
    case paymentRequired(payload: Data?)

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

    /// A generic error with a provided error object
    case generic(error: Swift.Error)

    /// Fallback error
    case unknown(payload: Data?)
}

extension NetswiftError {
    public var payload: Data? {
        switch self {
        case let .resourceNotFound(_, payload), let .resourceRemoved(_, payload):
            return payload
        case let .responseDecodingError(_, payload):
            return payload
        case let .serverError(payload):
            return payload
        case let .paymentRequired(payload):
            return payload
        case let .unknown(payload):
            return payload

        case .methodNotAllowed,
             .noResponseError,
             .notAuthenticated,
             .notPermitted,
             .preconditionFailed,
             .requestError,
             .requestSerialisationError,
             .responseCastingError,
             .timedOut,
             .tooManyRequests,
             .unexpectedResponseError,
             .generic:
            return nil
        }
    }
}

extension NetswiftError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .requestSerialisationError:
            return "The request couldn't be serialised before being sent out"
        case .requestError:
            return "The request couldn't be processed by the server"
        case .serverError:
            return "The server encountered an internal error while processing the request"
        case .resourceNotFound:
            return "The specified resource could not be found on the server (404)"
        case .resourceRemoved:
            return "The specified resource has been permanently removed"
        case .unexpectedResponseError:
            return "The response returned by the server does not conform to expected type"
        case .noResponseError:
            return "The response returned by the server is empty / nil"
        case .responseDecodingError:
            return "The response's raw data could not be understood"
        case .responseCastingError:
            return "The response could not be casted to the Request's IncomingType"
        case .notAuthenticated:
            return "Cannot authenticate the request; authentication needed"
        case .paymentRequired:
            return "The server requires payment data before it can process the request"
        case .notPermitted:
            return "The server didn't allow this request for this user"
        case .timedOut:
            return "The request took too long to return."
        case .preconditionFailed:
            return "The server does not meet one of the preconditions that the requester put on the request"
        case .methodNotAllowed:
            return "A request method is not supported for the requested resource"
        case .tooManyRequests:
            return "The user has sent too many requests in a given amount of time"
        case .generic(let error):
            return error.localizedDescription
        case .unknown:
            return "An unknown error occured"
        }
    }
}
