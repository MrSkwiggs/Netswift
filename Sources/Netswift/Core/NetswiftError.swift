//
//  NetswiftError.swift
//  Netswift
//
//  Created by Dorian Grolaux on 27/06/2018.
//  Copyright © 2018 Skwiggs. All rights reserved.
//

import Foundation

public struct NetswiftError: Swift.Error {
    
    public let category: Category
    public let payload: Data?
    
    public init(category: Category, payload: Data?) {
        self.category = category
        self.payload = payload
    }
    
    /// All the errors that can be raised while performing HTTP requests
    public enum Category {
        
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
    }
}

extension NetswiftError: Equatable {
    public static func == (lhs: NetswiftError, rhs: NetswiftError) -> Bool {
        switch (lhs.category, rhs.category) {
        case (.requestSerialisationError, .requestSerialisationError),
             (.requestError, .requestError),
             (.unexpectedResponseError, .unexpectedResponseError),
             (.noResponseError, .noResponseError),
             (.responseCastingError, .responseCastingError),
             (.notAuthenticated, .notAuthenticated),
             (.notPermitted, .notPermitted),
             (.timedOut, .timedOut),
             (.preconditionFailed, .preconditionFailed),
             (.methodNotAllowed, .methodNotAllowed),
             (.tooManyRequests, .tooManyRequests),
             (.serverError, .serverError),
             (.paymentRequired, .paymentRequired),
             (.resourceNotFound, .resourceNotFound),
             (.resourceRemoved, .resourceRemoved):
            return true
            
        case (.responseDecodingError(let lhsError), .responseDecodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
            
        default:
            return false
        }
    }
}

extension NetswiftError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self.category {
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
