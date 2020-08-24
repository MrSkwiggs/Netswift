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
        
        /// A generic error with a provided error object
        case generic(error: Swift.Error)
        
        /// Fallback error
        case unknown
        
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
            case .unknown:
                return "Unknown"
            }
        }
    }
}
