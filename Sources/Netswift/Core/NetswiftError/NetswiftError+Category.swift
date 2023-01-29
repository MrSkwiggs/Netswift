//
//  NetswiftError+Category.swift
//  Netswift
//
//  Created by Dorian Grolaux on 24/08/2020.
//  Copyright © 2020 Skwiggs. All rights reserved.
//

import Foundation

public extension NetswiftError {
    /// All the errors that can be raised while performing HTTP requests
    enum Category: CustomDebugStringConvertible {
        
        /// The request couldn't be serialised before being sent out
        case requestSerialisationError
        
        /// The request couldn't be processed by the server
        case requestError
        
        /// The server encountered an internal error while processing the request
        case serverError
        
        /// The specified resource could not be found on the server (404)
        case resourceNotFound
        
        /// The specified resource has been permanently removed
        case resourceRemoved
        
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
        
        /// The server requires payment data before it can process the request
        case paymentRequired
        
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
        
        /// The server understands the content type of the request entity, and the syntax of the request entity is correct, but it was unable to process the contained instructions.
        /// - warning: The client should not repeat this request without modification.
        case unprocessableEntity
        
        /// A generic error with a provided error object
        case generic(error: Swift.Error)
        
        /// Fallback error
        case unknown(httpStatusCode: Int?)
        
        public var debugDescription: String {
            switch self {
            case .generic:
                return "Generic Error"
            case .methodNotAllowed:
                return "Method Not Allowed"
            case .noResponseError:
                return "Empty Response"
            case .notAuthenticated:
                return "Authentication Needed"
            case .notPermitted:
                return "Not Permitted"
            case .paymentRequired:
                return "Payment Required"
            case .preconditionFailed:
                return "Precondition Failed"
            case .requestError:
                return "Wrong Request"
            case .requestSerialisationError:
                return "Serialisation Failed"
            case .resourceNotFound:
                return "Resource Not Found"
            case .resourceRemoved:
                return "Resource Removed"
            case .responseCastingError:
                return "Casting Error"
            case .responseDecodingError:
                return "Decoding Error"
            case .serverError:
                return "Server Error"
            case .timedOut:
                return "Request Timed Out"
            case .tooManyRequests:
                return "Too Many Requests"
            case .unexpectedResponseError:
                return "Unexpected Response"
            case .unprocessableEntity:
                return "Unprocessable Entity"
            case .unknown:
                return "Unknown"
            }
        }
    }
}

extension NetswiftError.Category {
    /// The corresponding HTTP status code if applicable
    public var httpStatusCode: Int? {
        switch self {
        case .requestError:
            return 400
        case .notAuthenticated:
            return 401
        case .paymentRequired:
            return 402
        case .notPermitted:
            return 403
        case .resourceNotFound:
            return 404
        case .methodNotAllowed:
            return 405
        case .preconditionFailed:
            return 412
        case .unprocessableEntity:
            return 422
        case .tooManyRequests:
            return 429
        case .serverError:
            return 500
        case .unknown(let statusCode):
            return statusCode
            
        case .generic,
             .noResponseError,
             .requestSerialisationError,
             .resourceRemoved,
             .responseCastingError,
             .responseDecodingError,
             .timedOut,
             .unexpectedResponseError:
            return nil
        }
    }
    
    /**
     Matches a HTTP status code to a NetswiftError.Category
     
     - Parameter httpStatusCode: The HTTP status code received with the network response
     
     - returns: The error category if successfully matched
     */
    static func from(httpStatusCode: Int) -> Self? {
        switch httpStatusCode {
        case 200...299:
            return nil
        case 400:
            return .requestError
        case 401:
            return .notAuthenticated
        case 402:
            return .paymentRequired
        case 403:
            return .notPermitted
        case 404:
            return .resourceNotFound
        case 405:
            return .methodNotAllowed
        case 412:
            return .preconditionFailed
        case 422:
            return .unprocessableEntity
        case 429:
            return .tooManyRequests
        case 500:
            return .serverError
        default:
            return .unknown(httpStatusCode: httpStatusCode)
        }
    }
}
